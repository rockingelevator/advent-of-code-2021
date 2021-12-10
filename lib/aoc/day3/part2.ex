defmodule Aoc.Day3.Part2 do
  @moduledoc """
  Day 3, Part 2
  [Binary Diagnostic](https://adventofcode.com/2021/day/3)
  """
  def go(file) do
    stream =
      File.stream!(file)
      |> Stream.map(&String.trim/1)

    input = Enum.to_list(stream)

    oxygen_rating = bit_filter(input, :common)
    co2_rating = bit_filter(input, :least)

    oxygen_rating * co2_rating
  end

  @doc """
  Returns a list of most :common or most :least bits at each position
  """
  def input_anchors(input, bit_type) do
    rows =
      input
      |> Enum.reduce([], fn row, acc ->
        chars = String.split(row, "", trim: true)

        if acc == [] do
          chars
        else
          acc
          |> Enum.with_index()
          |> Enum.map(fn {r, index} -> r <> Enum.at(chars, index) end)
        end
      end)

    Enum.map(rows, fn r -> find_bit(r, bit_type) end)
  end

  @doc """
  Helper func that returns most :common or most :least used bit in a row
  """
  def find_bit(row, bit_type) do
    {zero, ones} =
      row
      |> String.split("", trim: true)
      |> Enum.reduce({0, 0}, fn
        "0", {zeros, ones} -> {zeros + 1, ones}
        "1", {zeros, ones} -> {zeros, ones + 1}
      end)

    common_bit = (zero <= ones && "1") || "0"
    least_bit = (common_bit == "0" && "1") || "0"
    (bit_type == :common && common_bit) || least_bit
  end

  defp bit_filter(input, bit_type), do: bit_filter(input, bit_type, 0)

  defp bit_filter([num], _bit_type, _position) do
    {num, _} = Integer.parse(num, 2)
    num
  end

  defp bit_filter(input, bit_type, position) do
    bits = input_anchors(input, bit_type)
    filtered = Enum.filter(input, fn x -> String.at(x, position) == Enum.at(bits, position) end)
    bit_filter(filtered, bit_type, position + 1)
  end
end
