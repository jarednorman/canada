defmodule User do
  defstruct admin: false, id: nil
end

defmodule Post do
  defstruct user_id: nil
end

defimpl Canada.Can, for: User do
  def can?(%User{id: user_id}, action, %Post{user_id: user_id})
    when action in [:update, :read], do: true

  def can?(%User{admin: admin}, action, _)
    when action in [:update, :read], do: admin
end

defmodule Can do
  use Canada
end

defmodule CanadaTest do
  use ExUnit.Case

  def admin_user(), do: %User{admin: true, id: 1}
  def user(), do: %User{id: 2}
  def other_user(), do: %User{id: 3}

  def post() do
    %Post{user_id: user.id}
  end

  test "it identifies whether subject can read a resource" do
    assert admin_user |> Can.read? post
    assert user |> Can.read? post
    refute other_user |> Can.read? post
  end

  test "it identifies whether a subject can update a resource" do
    assert admin_user |> Can.update? post
    assert user |> Can.update? post
    refute other_user |> Can.update? post
  end
end
