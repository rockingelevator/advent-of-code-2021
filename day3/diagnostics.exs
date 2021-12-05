# Day 3, Part 1
defmodule Diagnostics do
  def go(file) do
    stream = File.stream!(file)
      |> Stream.map(&String.trim/1)

    input = Enum.to_list(stream)

    rows = input
      |> Enum.reduce([], fn (row, acc) ->
        chars = String.split(row, "", trim: true)
          if acc == [] do
            chars
          else
            acc
            |> Enum.with_index
            |> Enum.map(fn {r, index} -> r <> Enum.at(chars, index) end)
          end
        end)

    gamma_raw = Enum.map(rows, &maxbit/1)
    epsilon_raw = Enum.map(gamma_raw, &(&1 < 1 && 1 || 0))
    parse_raw = &(Integer.parse(Enum.join(&1, ""), 2))
    {gamma,_} = parse_raw.(gamma_raw)
    {epsilon,_} = parse_raw.(epsilon_raw)

    IO.puts "#{gamma * epsilon}"
  end

  defp maxbit(row) do
    {zero, ones} = row
      |> String.split("", trim: true)
      |> Enum.reduce({0, 0}, fn
        ("0", {zeros, ones}) -> {zeros + 1, ones}
        ("1", {zeros, ones}) -> {zeros, ones + 1}
      end)
    zero < ones && 1 || 0
  end

end
