require IEx
defmodule RussianPeasantMultiplication.Increment do

  import Monad.Result

  @errors %{
    zero: "Must be greater than zero",
    number: "Requested number and Max round must be numbers"
  }

  @doc """
  Accepts a monad of number and a monad list of decremented numbers, It will duplicates according the max number of dectemented input

  ### Examples

    iex> import Monad.Result
    iex> alias RussianPeasantMultiplication.Increment, as: RPM_Inc
    RussianPeasantMultiplication.Increment
    iex> first = success(238)
    iex> second = success([13, 6, 3, 1])
    iex> result = RPM_Inc.increment(first, second)
    iex> unwrap!(result)
    [238, 476, 952, 1904]
    iex> first = success(0)
    iex> second = success([])
    iex> result = RPM_Inc.increment(first, second)
    iex> result.error
    "Must be greater than zero"

  """

  def increment(
    %Monad.Result{type: :ok} = first,
    %Monad.Result{type: :ok} = second ) do
      second = second.value |> Enum.count
      increment(first.value, second)
  end

  def increment(a_number, _) when a_number <= 0, do: error(@errors.zero)
  def increment(_, max_round) when max_round <= 0, do: error(@errors.zero)
  def increment(a_number, max_round)
  when is_number(a_number) and is_number(max_round) do

    initial_state = fn(a_number) -> success([a_number]) end
    inc_func = fn(state) -> increment(a_number, state, max_round) end

    a_number
    |> initial_state.()
    |> inc_func.()
  end
  def increment(_a_number, _max_round), do: error(@errors.number)

  def increment(_a_number, state, max_round) when max_round <= 1, do: state
  def increment(a_number, state, max_round) do
    new_number = a_number |> double_it()

    state_fun = fn() ->
                  unwrap!(state)
                  |> Enum.concat([new_number])
                  |> success()
                end

    increment(new_number, state_fun.() , max_round - 1)
  end

  defp double_it(number), do: number * 2

end
