defmodule Exhttpd.Mixfile do
  use Mix.Project

  def project do
    [app: :exhttpd,
     version: "0.0.1",
     elixir: "~> 1.2",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    [applications: [:logger, :cowboy, :plug, :httpoison],
     mod: {Exhttpd, []}]
  end

  # Dependencies can be Hex packages:
  #
  #   {:mydep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:mydep, git: "https://github.com/elixir-lang/mydep.git", tag: "0.1.0"}
  #
  # Type "mix help deps" for more examples and options
  # something in here wants erlware_commons to be at 0.19.0
  # not sure what (relx?)
  # had to edit _build/dev/lib/erlware_commons/ebin/erlware_commons.app
  # (part) of this issue discussed at https://github.com/bitwalker/exrm/issues/294
  defp deps do
    [
     {:httpoison, git: "https://github.com/edgurgel/httpoison.git"},
     {:cowboy, "~> 1.0.0"},
     {:plug, "~> 1.0"}]
  end
end
