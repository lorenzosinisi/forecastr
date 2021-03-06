defmodule Forecastr.MixProject do
  use Mix.Project

  def project do
    [
      app: :forecastr,
      version: "0.1.5",
      elixir: "~> 1.6",
      description: description(),
      package: package(),
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      test_coverage: [tool: ExCoveralls],
      preferred_cli_env: [
        coveralls: :test,
        "coveralls.detail": :test,
        "coveralls.post": :test,
        "coveralls.html": :test
      ],
      elixirc_paths: elixirc_paths(Mix.env()),
      dialyzer: [plt_file: {:no_warn, ".dialyzer/local.plt"}]
    ]
  end

  def application do
    [
      extra_applications: [:logger],
      mod: {Forecastr.Application, []}
    ]
  end

  defp deps do
    [
      {:httpoison, "~> 1.1"},
      {:poison, "~> 3.1"},
      {:table, "~> 0.0.5"},
      {:dialyxir, "~> 0.5.1", only: [:dev], runtime: false},
      {:credo, "~> 0.9.0-rc1", only: [:dev, :test], runtime: false},
      {:excoveralls, "~> 0.8", only: :test},
      {:ex_doc, ">= 0.0.0", only: :dev},
      {:mogrify, "~> 0.6.0"}
    ]
  end

  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  defp description() do
    """
    Forecastr, the Elixir way to check the weather forecast
    """
  end

  defp package() do
    [
      files: [
        "config",
        "lib",
        "LICENSE",
        "mix.exs",
        "mix.lock",
        "README.md"
      ],
      maintainers: ["Marco Milanesi"],
      licenses: ["Apache 2.0"],
      links: %{
        "GitHub" => "https://github.com/kpanic/forecastr",
        "Contributors" => "https://github.com/kpanic/forecastr/graphs/contributors",
        "Issues" => "https://github.com/kpanic/forecastr/issues"
      }
    ]
  end
end
