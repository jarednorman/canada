defmodule User do
  defstruct admin: false, id: nil, verified: false
end

defmodule Post do
  defstruct user_id: nil
end

defimpl Canada.Can, for: User do
  def can?(%User{id: user_id}, action, %Post{user_id: user_id})
    when action in [:update, :read, :destroy], do: true

  def can?(%User{admin: admin}, action, _)
    when action in [:update, :read, :destroy], do: admin

  def can?(%User{verified: verified}, :create, Post), do: verified
end

defmodule Can do
  use Canada
end

defmodule CanadaTest do
  use ExUnit.Case

  def admin_user(), do: %User{admin: true, id: 1, verified: true}
  def user(), do: %User{id: 2, verified: true}
  def other_user(), do: %User{id: 3}

  def post(), do: %Post{user_id: user.id}

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

  test "it identifies whether a subject can destroy a resource" do
    assert admin_user |> Can.destroy? post
    assert user |> Can.destroy? post
    refute other_user |> Can.destroy? post
  end

  test "it identifies whether a subject can create a type of resource" do
    assert admin_user |> Can.create? Post
    assert user |> Can.create? Post
    refute other_user |> Can.create? Post
  end
end
