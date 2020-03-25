defmodule RussianPeasantMultiplication.Increament do

  import Monad.Result

  @errors %{
    zero: "Must be greater than zero",
    number: "Requested number and Max round must be numbers"
  }

  @doc """
  Accepts a number and max number of duplications, It will duplicates according the max number of duplications

  ### Examples

    iex> import Monad.Result
    iex> alias RussianPeasantMultiplication.Increament, as: RPM_Inc
    RussianPeasantMultiplication.Increament
    iex> result = RPM_Inc.increament(238, 4)
    iex> unwrap!(result)
    [238, 476, 952, 1904]
    iex> result = RPM_Inc.increament(0, 0)
    iex> result.error
    "Must be greater than zero"

  """
  def increament(a_number, _) when a_number <= 0, do: error(@errors.zero)
  def increament(_, max_round) when max_round <= 0, do: error(@errors.zero)
  def increament(a_number, max_round)
  when is_number(a_number) and is_number(max_round) do

    initial_state = fn(a_number) -> success([a_number]) end
    inc_func = fn(state) -> increament(a_number, state, max_round) end

    a_number
    |> initial_state.()
    |> inc_func.()
  end
  def increament(_a_number, _max_round), do: error(@errors.number)

  def increament(_a_number, state, max_round) when max_round <= 1, do: state
  def increament(a_number, state, max_round) do
    new_number = a_number |> double_it()

    state_fun = fn() ->
                  unwrap!(state)
                  |> Enum.concat([new_number])
                  |> success()
                end

    increament(new_number, state_fun.() , max_round - 1)
  end

  defp double_it(number), do: number * 2

end
