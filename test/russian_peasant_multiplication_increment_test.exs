defmodule RussianPeasantMultiplication.IncrementTest do
  use ExUnit.Case
  doctest RussianPeasantMultiplication.Increment

  import Monad.Result
  alias RussianPeasantMultiplication.Increment, as: RPM_Inc

  test "max number must be a number" do
    items = [ %{requested: success("238"), rounds: success([13, 6, 3, 1])},
            ]
    Enum.filter(items, fn(item) ->
      res = RPM_Inc.increment(item.requested, item.rounds)
      assert res.error == "Requested number and Max round must be numbers"
    end)
  end

  test "max number must be a number greater than zero" do
    res = RPM_Inc.increment(success(238), success([]))
    assert res.error == "Must be greater than zero"
  end


end
