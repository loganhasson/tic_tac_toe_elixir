defmodule TicTacToe.Game do
  def main(_args) do
    start
  end

  defp start do
    IO.puts "Welcome to Tic Tac Toe!"
    TicTacToe.Board.start |> play
  end

  defp play(board) do
    print_board(board)

    # todo:
      # * winner/winner?/draw? functions in TicTacToe.Board
      # * play loop
  end

  defp print_board(board) do
    output = TicTacToe.Board.board(board)

    IO.puts " #{Enum.at(output, 0)} | #{Enum.at(output, 1)} | #{Enum.at(output, 2)} "
    IO.puts "-----------"
    IO.puts " #{Enum.at(output, 3)} | #{Enum.at(output, 4)} | #{Enum.at(output, 5)} "
    IO.puts "-----------"
    IO.puts " #{Enum.at(output, 6)} | #{Enum.at(output, 7)} | #{Enum.at(output, 8)} "
  end
end
