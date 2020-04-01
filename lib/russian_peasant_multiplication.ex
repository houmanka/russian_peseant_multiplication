require IEx
defmodule RussianPeasantMultiplication do

  import MyInteger, only: [is_valid: 1]
  import Monad.Result
  use Monad.Operators

  alias RussianPeasantMultiplication.{
    Decrement, Increment, Combine, Filter, Sum }

  # defstruct first: 0, second: 0

  @errors %{
    zero: "Must be number greater than zero",
    number: "Requested number and Max round must be numbers"
  }

  @doc """
  accepts 2 numbers and return the multiplication of both numbers

  ### Examples

    iex> alias RussianPeasantMultiplication,as: RPM
    RussianPeasantMultiplication
    iex> RPM.multiply(13, 238)
    3094
    iex> RPM.multiply(13, -1)
    "Must be number greater than zero"

  """

  def multiply(first, second) when is_valid(first) and is_valid(second) do

    # data = %__MODULE__{first: first, second: second, originals: []}

    # result = success(data) # Wrap user with the "success" monad state
    #          ~>> fn data -> Decrement.decrement(data) end
    #          ~>> fn data -> Increment.increment(data) end
    #          ~>> fn data -> Combine.combine(data) end
    #          ~>> fn data -> Filter.filter(data) end

    first = success(first)
    second = success(second)
    with  decrement <- Decrement.decrement(first),
          increment <- Increment.increment(second, decrement),
          combine <- Combine.combine(decrement, increment),
          filter <- Filter.filter(combine),
          sum_of <- Sum.sum_of(filter) do
            sum_of |> unwrap!()
    end

  end
  def multiply(_first, _second), do: @errors.zero

end
