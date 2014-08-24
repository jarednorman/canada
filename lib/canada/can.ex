defprotocol Canada.Can do
  @doc "Evaluates permissions"
  def can?(subject, action, resource)
end
