defmodule Sonar do
  def sweep(file) do
    stream = File.stream!(file)
      |> Stream.map(fn line ->
        {num, _} = Integer.parse(line)
        num
      end)

      # V1 - Reduce
    {counter, _ } = Enum.to_list(stream)
      |> Enum.reduce({0, -1}, fn
        (depth, {_, previous}) when previous < 0 -> {0, depth}
        (depth, {c, previous}) when depth > previous  -> {c + 1, depth}
        (depth, {c, previous}) when depth <= previous  -> {c, depth}
      end)
    IO.puts "#{counter}"

    # v2 - Recursion
    # _sweep(0, input)
  end
  # def _sweep(counter, [_]), do: IO.puts "#{counter}"
  # def _sweep(counter, [depth, next | tail]) when depth < next do _sweep(counter + 1, [next | tail])
  # def _sweep(counter, [depth, next | tail]) when depth >= next, do: _sweep(counter, [next | tail])
end
