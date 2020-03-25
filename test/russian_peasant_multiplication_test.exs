defmodule RussianPeasantMultiplicationTest do
  use ExUnit.Case
  doctest RussianPeasantMultiplication

  alias RussianPeasantMultiplication, as: RPM

  test "Should return errors if inputs are incorrect" do
    [
      %{first: "we", second: "adf"},
      %{first: 13, second: "adf"},
      %{first: "we", second: 238},
      %{first: nil, second: 238},
      %{first: "we", second: nil},
    ]
    |> Enum.filter(fn(input) ->
       res = RPM.multiply(input.first, input.second)
       assert res == "Must be number greater than zero"
    end)
  end

  test "Should return errors if inputs are less than zero" do
      [
        %{first: 0, second: -1 },
        %{first: -1, second: 0},
        %{first: 0, second: 0}
      ]
      |> Enum.filter(fn(input) ->
         res = RPM.multiply(input.first, input.second)
         assert res == "Must be number greater than zero"
      end)

  end






end
