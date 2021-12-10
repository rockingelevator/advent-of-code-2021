defmodule Aoc.Day5Test do
  use ExUnit.Case

  doctest Aoc.Day5

  alias Aoc.Day5

  @input Path.join([Application.app_dir(:aoc), "priv", "day5", "test_input.txt"])

  test "Day 5, Hydrothermal Venture" do
    assert 12 == Day5.go(@input)
  end
end
