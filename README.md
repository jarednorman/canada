Canada: _Define you some permissions_
=====================================

Canada provides a friendly interface for making easy use of
[Elixir](http://elixir-lang.org/)'s excellent pattern matching to create
readable declarative permission rules.

Installation
------------

Add it to your deps list in your `mix.exs`. You want the latest release?

```elixir
defp deps do
  [{:canada, "~> 0.0.1"}]
end
```

You want the latest master?

```elixir
defp deps do
  [{:canada, github: "jarednorman/canada"}]
end
```

Becoming Canadian
-----------------

Becoming Canadian is easy. Presumably you have some kind of resource like a
user, and probably some kind of resource that belongs to users. Let's call that
hypothetical resource a "post". Let's say they're structs.

```elixir
defmodule User do
  defstruct id: nil, name: nil, admin: false
end

defmodule Post do
  defstruct user_id: nil, content: nil
end
```

To make use of Canada, you need to implement the `Canada.Can` protocol
(defining whatever rules you need) for the "subject" resource (your User struct
in this case) and then create a `Can` module for you to call into. This looks
like the following.

Note: This also defines an additional, custom action on top of the default CRUD
actions called `:touch`.

```elixir
defimpl Canada.Can, for: User do
  def can?(%User{id: user_id}, action, %Post{user_id: user_id})
    when action in [:update, :read, :destroy, :touch], do: true

  def can?(%User{admin: admin}, action, _)
    when action in [:update, :read, :destroy, :touch], do: admin

  def can?(%User{}, :create, Post), do: true
end

defmodule Can do
  use Canada, custom_actions: [:touch]
end
```

With this in place, you're good to start testing permissions wherever you need
to.

```elixir
if some_user |> Can.read? some_post do
  # render the post
else
  # raise a 403 or something
end
```

A note from the author
----------------------

This is very much what happened when I said to myself, "I want the thing I had
in Ruby, but in Elixir." I would be entirely unsurprised if myself or someone
else comes up with a more "functional" solution. That said, permissions are
necessarily a matter that governs conditional logic, so I currently see this as
a reasonable solution.
