defmodule User do
  defstruct admin: false
end

defimpl Canada.Can, for: User do
  def can?(%User{admin: admin}, :read, _), do: admin
  def can?(%User{admin: admin}, :update, _), do: admin
end

defmodule Can do
  use Canada
end

defmodule CanadaTest do
  use ExUnit.Case

  def admin_user(), do: %User{admin: true}
  def normal_user(), do: %User{}
  def resource(), do: %{}

  test "it identifies when subject can read a resource" do
    assert admin_user |> Can.read? resource
  end

  test "it identifies when subject can't read a resource" do
    refute normal_user |> Can.read? resource
  end

  test "it identifies when a subject can update a resource" do
    assert admin_user |> Can.update? resource
  end

  test "it identifies when a subject can't update a resource" do
    refute normal_user |> Can.update? resource
  end
end
