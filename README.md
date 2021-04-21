Canada: _Define you some permissions_
=====================================

[![Module Version](https://img.shields.io/hexpm/v/canada.svg)](https://hex.pm/packages/canada)
[![Hex Docs](https://img.shields.io/badge/hex-docs-lightgreen.svg)](https://hexdocs.pm/canada/)
[![Total Download](https://img.shields.io/hexpm/dt/canada.svg)](https://hex.pm/packages/canada)
[![License](https://img.shields.io/hexpm/l/canada.svg)](https://github.com/jarednorman/canada/blob/master/LICENSE)
[![Last Updated](https://img.shields.io/github/last-commit/jarednorman/canada.svg)](https://github.com/jarednorman/canada/commits/master)

> **NOTE:** If you're concerned by the fact that this repository has very
> little activity, don't be. The functionality this package provides is very
> simple, it has no dependencies, and the Elixir language hasn't changed in any
> way that would break it. It still works just as well as when I first wrote
> it. :smiley:

Canada provides a friendly interface for making easy use of
[Elixir](http://elixir-lang.org/)'s excellent pattern matching to create
readable declarative permission rules.

If you're looking for something that fills more of what CanCan would provide
you in a Rails application you should have a look at
[Canary](https://github.com/cpjk/canary) which adds Ecto/Plug support.

Installation
------------

Add it to your deps list in your `mix.exs` if you want the latest release?

```elixir
defp deps do
  [
    {:canada, "~> 2.0"}
  ]
end
```

Or you want the latest greatest master?

```elixir
defp deps do
  [
    {:canada, github: "jarednorman/canada"}
  ]
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
in this case).

```elixir
defimpl Canada.Can, for: User do
  def can?(%User{id: user_id}, action, %Post{user_id: user_id})
    when action in [:update, :read, :destroy, :touch], do: true

  def can?(%User{admin: admin}, action, _)
    when action in [:update, :read, :destroy, :touch], do: admin

  def can?(%User{}, :create, Post), do: true
end
```

With this in place, you're good to start testing permissions wherever you need
to, just remember to import the can? macro.

```elixir
import Canada, only: [can?: 2]

if some_user |> can? read(some_post) do
  # render the post
else
  # sorry (raise a 403)
end
```

A note from the author
----------------------

This is very much what happened when I said to myself, "I want the thing I had
in Ruby, but in Elixir." I would be entirely unsurprised if myself or someone
else comes up with a more "functional" solution. That said, permissions are
necessarily a matter that governs conditional logic, so I currently see this as
a reasonable solution.

## Copyright and License

Copyright (c) 2014 Jared Norman

This software is licensed under [the MIT license](./LICENSE.md).
