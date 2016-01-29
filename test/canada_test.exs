defmodule User do
  defstruct admin: false, id: nil, verified: false
end

defmodule Post do
  defstruct user_id: nil
end

defimpl Canada.Can, for: User do
  def can?(%User{id: user_id}, action, %Post{user_id: user_id})
    when action in [:update, :read, :destroy, :touch], do: true

  def can?(%User{admin: admin}, action, _)
    when action in [:update, :read, :destroy, :touch], do: admin

  def can?(%User{verified: verified}, :create, Post), do: verified
end

defmodule CanadaTest do
  use ExUnit.Case
  import Canada, only: [can?: 2]

  def admin_user(), do: %User{admin: true, id: 1, verified: true}
  def user(), do: %User{id: 2, verified: true}
  def other_user(), do: %User{id: 3}

  def post(), do: %Post{user_id: user.id}

  test "it identifies permissions based on custom actions" do
    assert admin_user |> can?(touch(post))
    assert user |> can?(touch(post))
    refute other_user |> can?(touch(post))
  end

  test "it identifies whether subject can read a resource" do
    assert admin_user |> can?(read(post))
    assert user |> can?(read(post))
    refute other_user |> can?(read(post))
  end

  test "it identifies whether a subject can update a resource" do
    assert admin_user |> can?(update(post))
    assert user |> can?(update(post))
    refute other_user |> can?(update(post))
  end

  test "it identifies whether a subject can destroy a resource" do
    assert admin_user |> can?(destroy(post))
    assert user |> can?(destroy(post))
    refute other_user |> can?(destroy(post))
  end

  test "it identifies whether a subject can create a type of resource" do
    assert admin_user |> can?(create(Post))
    assert user |> can?(create(Post))
    refute other_user |> can?(create(Post))
  end
end
