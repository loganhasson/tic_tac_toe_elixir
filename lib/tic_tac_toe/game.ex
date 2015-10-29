defmodule TicTacToe.Game do
  def main(_args) do
    start
  end

  defp start do
    IO.puts "Welcome to Tic Tac Toe!"
    TicTacToe.Board.start |> play(9)
  end

  defp play(board, moves) when moves === 1 do
  end

  defp play(board, moves) do
    print_board(board)
    pos = (IO.gets "Where would you like to move? (1-9): ")
          |> String.strip
          |> String.to_integer

    TicTacToe.Board.move(board, pos)

    play(board, moves - 1)
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
