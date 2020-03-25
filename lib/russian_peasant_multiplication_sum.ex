defmodule RussianPeasantMultiplication.Sum do

  import Monad.Result


  @doc """
  Accepts a list and return sum of the numbers

  ### Examples

    iex> import Monad.Result
    iex> alias RussianPeasantMultiplication.Sum, as: RPM_Sum
    RussianPeasantMultiplication.Sum
    iex> result = RPM_Sum.sum_of([238, 952, 1904])
    iex> unwrap!(result)
    3094

  """

  def sum_of([head | tail]) do
    sum_of(tail, success(head) )
  end

  def sum_of([], state), do: state
  def sum_of([head | tail], state) do
    new_state = head |> sum(state)
    sum_of(tail, new_state)
  end

  defp sum(num, state) do
    sum = fn(state) -> num + state end

    state
    |> unwrap!()
    |> sum.()
    |> success()
  end

end
