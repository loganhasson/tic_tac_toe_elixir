defmodule TicTacToe.Game do
  use GenServer

  def start do
    initial_board = [" ", " ", " ", " ", " ", " ", " ", " ", " "]
    {:ok, board} = GenServer.start(__MODULE__, initial_board)
    board
  end

  def board(board) do
    GenServer.call(board, :board)
  end

  def move(board, position) do
    GenServer.call(board, {:move, position})
  end

  def handle_call(:board, _from, board) do
    {:reply, board, board}
  end

  def handle_call({:move, position}, _from, board) do
    {status, board} = board |> _move(position)

    {:reply, {status, board}, board}
  end

  defp _move(board, position) do
    position = position - 1

    case Enum.fetch(board, position) do
      {:ok, " "} ->
        {:ok, List.replace_at(board, position, current_player(board))}
      {:ok, _} ->
        {:taken, board}
      :error ->
        {:error, board}
    end
  end

  defp current_player(board) do
    Enum.count(board, &(&1 === " "))
    |> convert_to_player
  end

  defp convert_to_player(empty_count) when rem(empty_count, 2) == 0 do
    "O"
  end
  defp convert_to_player(empty_count) when rem(empty_count, 2) != 0 do
    "X"
  end
end
