require IEx
defmodule RussianPeasantMultiplication do

  import MyInteger, only: [is_valid: 1]
  import Monad.Result

  alias RussianPeasantMultiplication.{
    Decreament, Increament, Combine, Filter, Sum }


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

  """

  def multiply(first, second) when is_valid(first) and is_valid(second) do

    # pass the first number to decreament
    dec_list = Decreament.decreament(first)
    dec_list = unwrap!(dec_list)

    # count the number of indexes
    max_round = Enum.count(dec_list)

    # pass the second number + the number of indexes to increament
    inc_list = Increament.increament(second, max_round)
    inc_list = unwrap!(inc_list)

    # combine increament and decreament into a list of tuples
    combine = Combine.combine(dec_list, inc_list)
    combine = unwrap!(combine)

    # remove the even number by filtering the first number
    filter = Filter.filter(combine)
    filter = unwrap!(filter)

    # Sum the second numbers in the map
    sum = Sum.sum_of(filter)
    unwrap!(sum)


  end
  def multiply(_first, _second), do: @errors.zero






end
