defmodule Location.MixProject do
  use Mix.Project

  def project do
    [
      app: :location,
      version: "0.1.0",
      elixir: "~> 1.15",
      elixirc_paths: elixirc_paths(Mix.env()),
      start_permanent: Mix.env() == :prod,
      description: description(),
      package: package(),
      deps: deps()
    ]
  end

  defp description do
    """
    Elixir library for accessing ISO3166-1 (country) and ISO3166-2 (subdivision) data as well as geoname data for cities. Source data comes from the upstream [debian iso-codes](https://salsa.debian.org/iso-codes-team/iso-codes) package.
    """
  end

  defp package do
    [
      files: ["lib", "priv", "mix.exs", "README*", "LICENSE*"],
      maintainers: ["Uku Taht"],
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/plausible/location"}
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger | extra_applications(Mix.env())]
    ]
  end

  defp extra_applications(env) when env in [:dev, :test], do: [:inets, :ssl, :xmerl]
  defp extra_applications(_env), do: []

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib"]
  defp elixirc_paths(_env), do: ["lib"]

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:jason, "~> 1.3"},
      {:nimble_csv, "~> 1.2"},
      {:floki, "~> 0.35.2"},
      {:tesla, "~> 1.8"},
      {:hackney, "~> 1.20"},
      {:flow, "~> 1.2"},
      {:unzip, "0.11.0"},
      {:csv, "~> 3.2"}
    ]
  end
end
