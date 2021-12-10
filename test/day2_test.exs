defmodule Aoc.Day2Test do
  use ExUnit.Case

  doctest Aoc.Day2

  alias Aoc.Day2

  @input Path.join([Application.app_dir(:aoc), "priv", "day2", "test_input.txt"])

  test "Day 2. Dive!" do
    assert 900 == Day2.dive(@input)
  end
end
