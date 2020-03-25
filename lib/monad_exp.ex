require IEx
defmodule ExampleMaybe do

  use Monad.Operators
  import Monad.Result

  def create(number1, number2) do
    result = success(number1) # Wrap user with the "success" monad state
             ~>> fn user -> do_something(user) end
             ~>> fn user -> do_something_else(user, number2) end

    if success?(result) do # %Monad.Result{type: :success, value: user}
      value = unwrap!(result) # Same as result.value
      # Display success to user
      IO.inspect value
    else
      # Display error to user
      result.error
    end
  end

  @spec do_something(any) :: Monad.Result.t()
  def do_something(a_number) do
    case 100 == a_number do
      true  -> success(a_number * 10)
      false -> error("Already purchased.")
    end
  end

  def do_something_else(number1, number2) do
    case 1000 == number1 do
      true  -> success(number1 * number2)
      false -> error("Boom.")
    end
  end


end
