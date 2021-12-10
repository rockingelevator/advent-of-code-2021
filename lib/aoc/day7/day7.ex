defmodule Aoc.Day7 do
  @moduledoc """
  Day 7
  [The Treachery of Whales](https://adventofcode.com/2021/day/7)
  """
  def count(input) do
    positions =
      input
      |> String.split(",", trim: true)
      |> Enum.map(&String.to_integer/1)

    position_chart =
      positions
      |> Enum.reduce(%{}, fn x, chart ->
        Map.update(chart, x, 1, &(&1 + 1))
      end)

    unique_positions = position_chart |> Map.keys()
    {min_position, max_position} = Enum.min_max(unique_positions)

    distance_chart =
      min_position..max_position
      |> Enum.reduce(%{}, fn key, chart ->
        fuel =
          unique_positions
          |> Enum.reduce(0, fn pos, total ->
            {min, max} = Enum.min_max([key, pos])
            ## total + number_of_ships_at_this_position * distance_between_positions
            # part 1
            # total + position_chart[pos] * (max - min)
            # part 2
            d = max - min
            cost = Enum.sum(0..d)
            total + position_chart[pos] * cost
          end)

        Map.merge(chart, %{key => fuel})
      end)

    [min_fuel | _] = distance_chart |> Map.values() |> Enum.sort(&(&1 <= &2))

    min_fuel
  end
end
