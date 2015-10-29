defmodule TicTacToe.Board do
  use GenServer

  @winning_combinations [
    [0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3, 6],
    [1, 4, 7], [2, 5, 8], [0, 4, 8], [2, 4, 6]
  ]

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

  def winner(board) do
    GenServer.call(board, :winner)
  end

  def handle_call(:board, _from, board) do
    {:reply, board, board}
  end

  def handle_call({:move, position}, _from, board) do
    {status, board} = board |> _move(position)

    {:reply, {status, board}, board}
  end

  def handle_call(:winner, _from, board) do
    {:reply, board |> _winner, board}
  end

  defp _move(board, position) do
    position = position - 1
    Enum.fetch(board, position) |> handle_move(board, position)
  end

  defp handle_move({:ok, " "}, board, position) do
    {:ok, List.replace_at(board, position, current_player(board))}
  end
  defp handle_move({:ok, _}, board, _position) do
    {:taken, board}
  end
  defp handle_move(:error, board, _position) do
    {:error, board}
  end

  defp _winner(board) do
    Enum.filter_map(@winning_combinations, &is_winning_combo(board, &1), &get_winner(&1, board))
    |> List.first
  end

  defp is_winning_combo(board, combo) do
    Enum.map(combo, &(Enum.at(board, &1)))
    |> all_one_token
  end

  defp get_winner(combo, board), do: Enum.at(board, List.first(combo))

  defp all_one_token(tokens) do
    Enum.all?(tokens, &(&1 == "X")) || Enum.all?(tokens, &(&1 == "O"))
  end

  defp current_player(board) do
    Enum.count(board, &(&1 === " ")) |> convert_count_to_player
  end

  defp convert_count_to_player(empty_count) when rem(empty_count, 2) == 0, do: "O"
  defp convert_count_to_player(empty_count) when rem(empty_count, 2) != 0, do: "X"
end
