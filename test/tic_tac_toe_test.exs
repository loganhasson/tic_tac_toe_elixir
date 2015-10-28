defmodule TicTacToeTest do
  use ExUnit.Case

  setup do
    board = TicTacToe.Board.start
    {:ok, board: board}
  end

  test "it creates an empty board on start", %{board: board} do
    assert TicTacToe.Board.board(board) === [" ", " ", " ", " ", " ", " ", " ", " ", " "]
  end

  test "it makes the first move as X", %{board: board} do
    {:ok, board} = TicTacToe.Board.move(board, 1)
    assert List.first(board) === "X"
  end

  test "it makes the second move as O", %{board: board} do
    TicTacToe.Board.move(board, 1)
    {:ok, board} = TicTacToe.Board.move(board, 2)
    assert Enum.at(board, 1) === "O"
  end

  test "it doesn't allow out of range moves", %{board: board} do
    {result, _} = TicTacToe.Board.move(board, 10)
    assert result === :error
  end

  test "it doesn't allow moves in spaces that have already been taken", %{board: board} do
    TicTacToe.Board.move(board, 1)
    {result, _} = TicTacToe.Board.move(board, 1)
    assert result === :taken
  end
end
