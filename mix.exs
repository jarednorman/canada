defmodule Canada.Mixfile do
  use Mix.Project

  @source_url "https://github.com/jarednorman/canada"
  @version "2.0.0"

  def project do
    [
      app: :canada,
      version: @version,
      elixir: "~> 1.0",
      consolidate_protocols: Mix.env() != :test,
      package: package(),
      deps: deps(),
      docs: docs()
    ]
  end

  def package do
    [
      description: "A DSL for declarative permissions",
      maintainers: ["Jared Norman"],
      contributors: ["Jared Norman"],
      licenses: ["MIT"],
      links: %{
        GitHub: @source_url
      }
    ]
  end

  def application do
    [
      applications: []
    ]
  end

  defp deps do
    [
      {:ex_doc, ">= 0.0.0", only: :dev, runtime: false}
    ]
  end

  defp docs do
    [
      extras: [
        "CHANGELOG.md",
        "LICENSE.md": [title: "License"],
        "README.md": [title: "Readme"]
      ],
      main: "readme",
      source_url: @source_url,
      source_ref: "v#{@version}",
      api_reference: false,
      formatters: ["html"]
    ]
  end
end
