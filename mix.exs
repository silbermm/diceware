defmodule Diceware.MixProject do
  use Mix.Project

  def project do
    [
      app: :diceware,
      description: "Generate passphrases using the Diceware method",
      package: package(),
      version: "0.2.1",
      elixir: "~> 1.10",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      {:credo, "~> 1.4", only: [:dev, :test], runtime: false},
      {:ex_doc, ">= 0.0.0", only: :dev, runtime: false},
      {:dialyxir, "~> 1.0", only: [:dev], runtime: false},
      {:stream_data, "~> 0.5.0", only: [:dev, :test]}
    ]
  end

  defp package do
    [
      licenses: ["3-Clause BSD License"],
      files: ["lib", "mix.exs", "README.md", "LICENSE*", "priv"],
      maintainers: ["Matt Silbernagel"],
      links: %{:GitHub => "https://github.com/silbermm/diceware"}
    ]
  end
end
