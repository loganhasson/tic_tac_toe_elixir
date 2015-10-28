defmodule TicTacToe.Mixfile do
  use Mix.Project

  def project do
    [app: :tic_tac_toe,
     version: "0.0.1",
     elixir: "~> 1.0",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     escript: escript,
     deps: deps]
  end

  def escript do
    [main_module: TicTacToe.Game]
  end

  def application do
    [applications: [:logger]]
  end

  defp deps do
    []
  end
end
