defmodule Canada do
  defmacro __using__(_) do
    alias Canada.Can
    quote do
      def read?(subject, resource) do
        Can.can?(subject, :read, resource)
      end
    end
  end
end
