defmodule Aoc.Day7Test do
  use ExUnit.Case

  doctest Aoc.Day7

  alias Aoc.Day7

  @input "16,1,2,0,4,2,7,1,2,14"

  test "Day 7" do
    assert 168 == Day7.count(@input)
  end
end
