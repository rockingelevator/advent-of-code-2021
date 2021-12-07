# Day 1, Part 2
defmodule Sonar do

  def sweep(file) do
    stream = File.stream!(file)
      |> Stream.map(fn line ->
        {num, _} = Integer.parse(line)
        num
      end)

    # {counter, previous_sum, window1, window2}
    {counter, _, _, _} = Enum.to_list(stream)
      |> Enum.with_index
      |> Enum.reduce({0, 0, [], []}, &iter/2)
    IO.puts "#{counter}"
  end

  def iter({depth, index}, {_, _, _, _}) when index == 0, do:  {0, 0, [depth], []}

  def iter({depth, _}, {c, previous, win1, win2}) when length(win1) == 2 do
    s = Enum.sum(win1) + depth
    {previous > 0 && s > previous && c + 1 || c, s, win2 ++ [depth], [depth]}
  end
  def iter({depth, _}, {c, previous, win1, win2}), do: {c, previous, win1 ++ [depth], win2 ++ [depth]}
end
