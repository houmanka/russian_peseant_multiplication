defmodule RussianPeasantMultiplication.IncreamentTest do
  use ExUnit.Case
  doctest RussianPeasantMultiplication.Increament

  import Monad.Result
  alias RussianPeasantMultiplication.Increament, as: RPM_Inc

  test "max number must be a number" do
    items = [ %{requested: "238", max_round: "4"},
              %{requested: 238, max_round: "4"},
              %{requested: "238", max_round: 4}
            ]
    Enum.filter(items, fn(item) ->
      res = RPM_Inc.increament(item.requested, item.max_round)
      assert res.error == "Requested number and Max round must be numbers"
    end)
  end

  test "max number must be a number greater than zero" do
    res = RPM_Inc.increament(238, 0)
    assert res.error == "Must be greater than zero"
  end


end
