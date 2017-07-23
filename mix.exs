defmodule Canada.Mixfile do
  use Mix.Project

  def project do
    [app: :canada,
     version: "1.0.2",
     elixir: "~> 1.0",
     package: package(),
     consolidate_protocols: Mix.env != :test,
     description: """
       A DSL for declarative permissions
     """,
     deps: deps(),
     docs: docs()]
  end

  def package do
    [maintainers: ["Jared Norman"],
     contributors: ["Jared Norman"],
     licenses: ["MIT"],
     links: %{github: "https://github.com/jarednorman/canada"}]
  end

  def application do
    [applications: []]
  end

  defp deps do
    [{:ex_doc, ">= 0.0.0", only: :dev}]
  end

  defp docs do
    [extras: ["README.md"]]
  end
end
