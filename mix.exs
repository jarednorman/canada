defmodule Canada.Mixfile do
  use Mix.Project

  def project do
    [app: :canada,
     version: "1.0.0",
     elixir: "~> 1.0",
     package: package,
     description: """
       A DSL for declarative permissions
     """,
     deps: deps]
  end

  def package do
    [contributors: ["Jared Norman"],
     licenses: ["MIT"],
     links: %{github: "https://github.com/jarednorman/canada"}]
  end

  def application do
    [applications: []]
  end

  defp deps do
    []
  end
end
