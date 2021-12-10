defmodule Aoc.Day3.Part1 do
  @moduledoc """
  Day 3, Part 1
  [Binary Diagnostic](https://adventofcode.com/2021/day/3)
  The main idea is to treat the input as a matrix
  and 1. convert columns to rows
  then 2. find the most common row item ("1" or "0") in each row (list of chars)
  finaly 3. convert string to decimal
  """
  def go(file) do
    input =
      File.stream!(file)
      |> Stream.map(&String.trim/1)
      |> Enum.to_list()

    # 1.
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

    # 2.
    gamma_raw = Enum.map(rows, &maxbit/1)
    epsilon_raw = Enum.map(gamma_raw, &((&1 < 1 && 1) || 0))

    # 3.
    parse_raw = &Integer.parse(Enum.join(&1, ""), 2)
    {gamma, _} = parse_raw.(gamma_raw)
    {epsilon, _} = parse_raw.(epsilon_raw)

    gamma * epsilon
  end

  # 2.
  defp maxbit(row) do
    {zero, ones} =
      row
      |> String.split("", trim: true)
      |> Enum.reduce({0, 0}, fn
        "0", {zeros, ones} -> {zeros + 1, ones}
        "1", {zeros, ones} -> {zeros, ones + 1}
      end)

    (zero < ones && 1) || 0
  end
end
