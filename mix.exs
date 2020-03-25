defmodule RussianPeasantMultiplication.MixProject do
  use Mix.Project

  def project do
    [
      app: :russian_peasant_multiplication,
      version: "0.1.0",
      elixir: "~> 1.9",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {RussianPeasantMultiplication.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:monadex, "~> 1.1.3"},
      {:justify, "~> 1.1.0"}
    ]
  end
end
