defmodule RussianPeasantMultiplication.Decreament do

  import Monad.Result

  @errors %{
    zero: "Must be greater than zero",
    number_only: "Must be non negetive number"
  }

  @doc """
  Accepts a number and reduce this number to be <= 1

  ### Examples

    iex> import Monad.Result
    iex> alias RussianPeasantMultiplication.Decreament, as: RPM_Dec
    RussianPeasantMultiplication.Decreament
    iex> result = RPM_Dec.decreament(13)
    iex> unwrap!(result)
    [13, 6, 3, 1]
    iex> result = RPM_Dec.decreament(0)
    iex> result.error
    "Must be greater than zero"
    iex> result = RPM_Dec.decreament("asdf")
    iex> result.error
    "Must be non negetive number"

  """

  def decreament(a_number) when a_number <= 0, do: error(@errors.zero)
  def decreament(a_number) when is_number(a_number) do
    state_func = fn(a_number) -> [a_number] |> success() end
    decreament_func = fn(state) -> decreament(a_number, state) end

    a_number
    |> state_func.()
    |> decreament_func.()
  end
  def decreament(_), do: error(@errors.number_only)

  def decreament(a_number, state) when(a_number) <= 1, do: state
  def decreament(a_number, state) when is_number(a_number) do
    state = unwrap!(state)
    new_number = (a_number / 2) |> Kernel.trunc
    decreament(new_number, success(Enum.concat(state, [new_number])))
  end

end
