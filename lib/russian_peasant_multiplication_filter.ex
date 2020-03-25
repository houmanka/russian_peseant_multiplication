defmodule RussianPeasantMultiplication.Filter do

  import Monad.Result
  require Integer

  @errors %{
    list: "Args must be list"
  }

  @doc """
  Accepts a list of tuple and remove the index if the
  tuple's first number is even and return the second number
  list1 = [{13, 238}, {6, 476}, {3, 952}, {1, 1904}]
  expected = [238, 952, 1904]

  ### Examples

    iex> import Monad.Result
    iex> alias RussianPeasantMultiplication.Filter, as: RPM_Filter
    RussianPeasantMultiplication.Filter
    iex> list = [{13, 238}, {6, 476}, {3, 952}, {1, 1904}]
    iex> result = RPM_Filter.filter(list)
    iex> unwrap!(result)
    [238, 952, 1904]

  """
  def filter(list) when is_list(list) do
    filter(list, [])
  end
  def filter(_), do: error(@errors.list)


  defp filter(list, state) do
    func = fn({item1, item2}) ->
      case Integer.is_odd(item1) do
        true -> [{item1, item2}]
        false -> [nil]
      end
    end
    filter(list, func, success(state))
  end

  defp filter([], _func, state), do: state
  defp filter([head | tail], func, state) do
    new_state = func.(head) |> concat(state)

    filter(tail, func, new_state)
  end

  defp concat([{_item1, item2}], state) do
    state
    |> unwrap!()
    |> Enum.filter(&!is_nil&1)
    |> Enum.concat([item2])
    |> success()
  end
  defp concat(_, state), do: state


end
