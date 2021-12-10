# Day 2
defmodule Aoc.Day2 do
  @moduledoc """
  Day2
  [Dive](https://adventofcode.com/2021/day/2)
  """
  def dive(file) do
    input =
      File.stream!(file)
      |> Stream.map(&parse_line/1)
      |> Enum.to_list()

    dive_step(0, 0, 0, input)
  end

  defp parse_line(line) do
    [direction, val] = String.split(line)
    {num, _} = Integer.parse(val)
    {String.to_atom(direction), num}
  end

  defp dive_step(position, depth, _aim, []), do: position * depth

  defp dive_step(position, depth, aim, [{direction, num} | tail]) when direction == :forward do
    dive_step(position + num, depth + num * aim, aim, tail)
  end

  defp dive_step(position, depth, aim, [{direction, num} | tail]) do
    dive_step(position, depth, (direction === :down && aim + num) || aim - num, tail)
  end
end
