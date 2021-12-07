# Day 2
defmodule Dive do
  def go(file) do
    stream = File.stream!(file)
      |> Stream.map(&parse_line/1)

      input = Enum.to_list(stream)
      IO.puts "#{dive_step(0, 0, 0, input)}"
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
    dive_step(position, depth, direction === :down && aim + num || aim - num, tail)
  end
end