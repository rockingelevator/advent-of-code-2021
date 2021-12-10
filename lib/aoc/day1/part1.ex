defmodule Aoc.Day1.Part1 do
  @moduledoc """
  Day 1. Part 1
  [Sonar Sweep](https://adventofcode.com/2021/day/1)
  """
  def sweep(file) do
    input =
      File.stream!(file)
      |> Stream.map(fn line ->
        {num, _} = Integer.parse(line)
        num
      end)
      |> Enum.to_list()

    # V1 - Reduce
    {counter, _} =
      input
      |> Enum.reduce({0, -1}, fn
        depth, {_, previous} when previous < 0 -> {0, depth}
        depth, {c, previous} when depth > previous -> {c + 1, depth}
        depth, {c, previous} when depth <= previous -> {c, depth}
      end)

    counter

    # v2 - Recursion
    # _sweep(0, input)
  end

  # def _sweep(counter, [_]), do: IO.puts "#{counter}"
  # def _sweep(counter, [depth, next | tail]) when depth < next do _sweep(counter + 1, [next | tail])
  # def _sweep(counter, [depth, next | tail]) when depth >= next, do: _sweep(counter, [next | tail])
end
