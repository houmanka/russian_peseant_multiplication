defmodule RussianPeasantMultiplication.CombineTest do
  use ExUnit.Case
  doctest RussianPeasantMultiplication.Combine
  import Monad.Result


  alias RussianPeasantMultiplication.Combine, as: Combine

  test "needs to create tuple from 2 lists" do
    res = Combine.combine([13, 6, 3, 1], [238, 476, 952, 1904]) |> unwrap!
    assert res == [{13, 238}, {6, 476}, {3, 952}, {1, 1904}]
  end

end
