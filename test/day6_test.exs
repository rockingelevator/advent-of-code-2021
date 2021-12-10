defmodule Aoc.Day6Test do
  use ExUnit.Case

  doctest Aoc.Day6

  alias Aoc.Day6

  test "Day 6, Lanternfish" do
    assert 5934 == Day6.count("3,4,3,1,2", 80)
  end
end
