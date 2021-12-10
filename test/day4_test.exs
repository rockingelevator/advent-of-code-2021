defmodule Aoc.Day4Test do
  use ExUnit.Case

  doctest Aoc.Day4.Part1
  doctest Aoc.Day4.Part2

  alias Aoc.Day4.Part1
  alias Aoc.Day4.Part2

  @input Path.join([Application.app_dir(:aoc), "priv", "day4", "test_input.txt"])
  @numbers "7,4,9,5,11,17,23,2,0,14,21,24,10,16,13,6,15,25,12,22,18,20,8,19,3,26,1"

  test "Day 4, Bingo, Part 1" do
    assert 4512 == Part1.bingo(@numbers, @input)
  end

  test "Day 4, Bingo, Part 2" do
    assert 1924 == Part2.bingo(@numbers, @input)
  end
end
