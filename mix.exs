defmodule ExMagick.MixProject do
  use Mix.Project

  def project do
    [
      app: :ex_magick,
      version: "0.2.1",
      elixir: "~> 1.5",
      start_permanent: Mix.env() == :prod,
      description: "Simply ImageMagick wrapper for Elixir",
      package: [
        maintainers: ["Tamaki Maeda"],
        licenses: ["MIT"],
        links: %{
          "GitHub" => "https://github.com/giraphme/ex_magick"
        }
      ],
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
      {:ex_doc, "~> 0.16", only: :dev, runtime: false}
    ]
  end
end
