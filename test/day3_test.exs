defmodule Aoc.Day3Test do
  use ExUnit.Case

  doctest Aoc.Day3.Part1
  doctest Aoc.Day3.Part2

  alias Aoc.Day3.Part1
  alias Aoc.Day3.Part2

  @input Path.join([Application.app_dir(:aoc), "priv", "day3", "test_input.txt"])

  test "Binary Diagnostics. Part 1" do
    assert 198 = Part1.go(@input)
  end

  test "Binary Diagnostics. Part 2" do
    assert 230 = Part2.go(@input)
  end
end
