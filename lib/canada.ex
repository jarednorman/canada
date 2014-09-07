defmodule Canada do
  defmacro can?(subject, {action, _, [argument]}) do
    quote do
      Canada.Can.can? unquote(subject), unquote(action), unquote(argument)
    end
  end
end
