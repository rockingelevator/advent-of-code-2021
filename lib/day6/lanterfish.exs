# Day 6, Lanterfishes
# Part 1

# The idea is to create a simple map
# where group fish by its timer
# { timer: count_of_fish_with_this_timer }
# then for each day we just have to swap values
# and add extra incrementation logic for 6 and 8

defmodule Lanterfish do
  def count(input, days) do
    fishes =
      input
      |> String.split(",", trim: true)
      |> Enum.map(&String.to_integer/1)

    # blank chart
    chart = Map.new(0..8, fn x -> {x, 0} end)
    # populate with initial fishes
    chart =
      fishes
      |> Enum.reduce(chart, fn fish, chart ->
        Map.update(chart, fish, 0, &(&1 + 1))
      end)

    chart =
      1..days
      |> Enum.reduce(chart, fn _, chart ->
        c = Map.new(0..7, fn x -> {x, chart[x + 1]} end)

        Map.merge(c, %{
          6 => chart[0] + chart[7],
          8 => chart[0]
        })
      end)

    chart |> Map.values() |> Enum.sum()
  end
end
