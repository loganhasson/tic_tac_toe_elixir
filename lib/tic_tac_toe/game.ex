defmodule TicTacToe.Game do
  alias TicTacToe.Board, as: Board

  def main(_args) do
    start
  end

  defp start do
    IO.puts "Welcome to Tic Tac Toe!\n"
    Board.start |> play
  end

  defp play(board) do
    cond do
      needs_moves(board) ->
        print_board(board)
        make_move(board)
      is_draw(board) ->
        end_game(board, :draw)
      has_winner(board) ->
        end_game(board, :winner)
    end
  end

  defp make_move(board) do
    pos = (IO.gets "Where would you like to move? (1-9): ")
          |> String.strip
          |> String.to_integer

    case Board.move(board, pos) do
      {:ok, _} -> play(board)
      {:taken, _} ->
        IO.puts "That position is taken...make another move!\n"
        make_move(board)
      {:error, _} ->
        IO.puts "Invalid move...make another one!\n"
        make_move(board)
    end
  end

  defp end_game(board, :draw) do
    IO.puts "Cat's Game!\n"
    print_board(board)
  end
  defp end_game(board, :winner) do
    IO.puts "#{Board.winner(board)} Wins!\n"
    print_board(board)
  end

  defp needs_moves(board) do
    Board.is_full(board) === false && Board.has_winner(board) === false
  end

  defp is_draw(board) do
    Board.is_draw(board) === true
  end

  defp has_winner(board) do
    Board.has_winner(board) === true
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
