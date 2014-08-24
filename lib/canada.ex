defmodule Canada do
  @default_actions [:create, :read, :update, :destroy]
  defmacro __using__(opts) do
    custom_actions = Keyword.get(opts, :custom_actions, [])
    Enum.concat(@default_actions, custom_actions)
    |> Enum.map fn(action) ->
      quote do
        def unquote(String.to_atom("#{action}?"))(subject, resource) do
          Canada.Can.can?(subject, unquote(action), resource)
        end
      end
    end
  end
end
