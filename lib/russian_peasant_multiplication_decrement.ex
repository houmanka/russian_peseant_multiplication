defmodule RussianPeasantMultiplication.Decrement do

  import Monad.Result

  @errors %{
    zero: "Must be greater than zero",
    number_only: "Must be non negetive number"
  }

  @doc """
  Accepts a monad of a number and reduce this number to be <= 1

  ### Examples

    iex> import Monad.Result
    iex> alias RussianPeasantMultiplication.Decrement, as: RPM_Dec
    RussianPeasantMultiplication.Decrement
    iex> result = success(13) |> RPM_Dec.decrement()
    iex> unwrap!(result)
    [13, 6, 3, 1]
    iex> result = success(0) |> RPM_Dec.decrement()
    iex> result.error
    "Must be greater than zero"
    iex> result = success("asdf") |> RPM_Dec.decrement()
    iex> result.error
    "Must be non negetive number"

  """

  def decrement(%Monad.Result{type: :ok} = state) do
    state.value
    |> decrement
  end
  def decrement(a_number) when a_number <= 0, do: error(@errors.zero)
  def decrement(a_number) when is_number(a_number) do
    state_func = fn(a_number) -> [a_number] |> success() end
    decrement_func = fn(state) -> decrement(a_number, state) end

    a_number
    |> state_func.()
    |> decrement_func.()
  end
  def decrement(_), do: error(@errors.number_only)

  def decrement(a_number, state) when(a_number) <= 1, do: state
  def decrement(a_number, state) when is_number(a_number) do
    state = unwrap!(state)
    new_number = (a_number / 2) |> Kernel.trunc
    decrement(new_number, success(Enum.concat(state, [new_number])))
  end

end
