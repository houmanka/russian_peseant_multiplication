defmodule RussianPeasantMultiplication.Combine do

  import Monad.Result

  @errors %{
    list: "Args must be list"
  }

  @doc """
  Accepts 2 lists, create a list of tuples.
  list1 = [13, 6, 3, 1]
  list2 = [238, 476, 952, 1904]
  expected = [{13, 238}, {6, 476}, {3, 952}, {1, 1904}]

  ### Examples

    iex> import Monad.Result
    iex> alias RussianPeasantMultiplication.Combine, as: RPM_Combine
    RussianPeasantMultiplication.Combine
    iex> list1 = [13, 6, 3, 1]
    iex> list2 = [238, 476, 952, 1904]
    iex> result = RPM_Combine.combine(list1, list2)
    iex> unwrap!(result)
    [{13, 238}, {6, 476}, {3, 952}, {1, 1904}]

  """
  def combine(list1, list2) when is_list(list1) and is_list(list2) do
    combine([list1, list2])
  end
  def combine(_, _), do: error(@errors.list)


  defp combine([_list1, _list2] = lists) do
    func = fn(f_head, s_head) -> [{f_head, s_head}] end
    combine(lists, func, success([]))
  end

  defp combine([[], []], _func, state), do: state
  defp combine([[f_head | f_tail], [s_head | s_tail]], func, state) do
    new_state = func.(f_head, s_head) |> concat(state)

    combine([f_tail, s_tail], func, new_state)
  end

  defp concat(list, state) do
    state
    |> unwrap!()
    |> Enum.filter(&!is_nil&1)
    |> Enum.concat(list)
    |> success()
  end


end
