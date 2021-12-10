defmodule Aoc.Day1Test do
  use ExUnit.Case

  doctest Aoc.Day1.Part1
  doctest Aoc.Day1.Part2

  alias Aoc.Day1.Part1
  alias Aoc.Day1.Part2

  @input Path.join([Application.app_dir(:aoc), "priv", "day1", "test_input.txt"])

  test "sonar sweep test. part 1" do
    assert Part1.sweep(@input) == 7
  end

  test "sonar sweep test. part 2" do
    assert Part2.sweep(@input) == 5
  end
end
