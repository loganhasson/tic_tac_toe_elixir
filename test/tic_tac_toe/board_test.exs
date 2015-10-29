defmodule TicTacToe.BoardTest do
  use ExUnit.Case

  setup do
    board = TicTacToe.Board.start

    winning_board = TicTacToe.Board.start
    TicTacToe.Board.move(winning_board, 1)
    TicTacToe.Board.move(winning_board, 4)
    TicTacToe.Board.move(winning_board, 2)
    TicTacToe.Board.move(winning_board, 5)
    TicTacToe.Board.move(winning_board, 3)

    full_board = TicTacToe.Board.start
    TicTacToe.Board.move(full_board, 1)
    TicTacToe.Board.move(full_board, 2)
    TicTacToe.Board.move(full_board, 3)
    TicTacToe.Board.move(full_board, 4)
    TicTacToe.Board.move(full_board, 5)
    TicTacToe.Board.move(full_board, 6)
    TicTacToe.Board.move(full_board, 7)
    TicTacToe.Board.move(full_board, 8)
    TicTacToe.Board.move(full_board, 9)

    {:ok, board: board, winning_board: winning_board, full_board: full_board}
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

  test "it knows that there is no winner", %{board: board} do
    assert TicTacToe.Board.winner(board) === nil
  end

  test "it knows when there is no winner", %{board: board} do
    assert TicTacToe.Board.has_winner(board) === false
  end

  test "it knows that there is a winner", %{winning_board: winning_board} do
    assert TicTacToe.Board.winner(winning_board) === "X"
  end

  test "it knows when there is a winner", %{winning_board: winning_board} do
    assert TicTacToe.Board.has_winner(winning_board) === true
  end

  test "it knows when the board is not full", %{board: board} do
    assert TicTacToe.Board.is_full(board) === false
  end

  test "it knows when the board is full", %{full_board: full_board} do
    assert TicTacToe.Board.is_full(full_board) === true
  end
end
