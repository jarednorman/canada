defprotocol Canada.Can do
  @fallback_to_any true

  @doc "Evaluates permissions"
  def can?(subject, action, resource)
end
