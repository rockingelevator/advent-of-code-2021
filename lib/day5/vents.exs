# Day 5, Hydrothermal Venture
# Part 2

defmodule Vents do
  def go(file) do
    lines =
      File.stream!(file)
      |> Stream.map(fn row ->
        row
        |> String.split(" -> ", trim: true)
        |> Enum.map(fn point ->
          String.split(point, ",", trim: true)
          |> Enum.map(&(&1 |> String.trim() |> String.to_integer()))
          |> List.to_tuple()
        end)
        |> List.to_tuple()
      end)
      |> Enum.to_list()
      # get only vertical, horizontal and 45deg lines
      |> Enum.filter(fn {{x_start, y_start}, {x_end, y_end}} ->
        # x_start == x_end || y_start == y_end
        x_start == x_end || y_start == y_end || abs(x_start - x_end) == abs(y_start - y_end)
      end)

    chart =
      lines
      |> Enum.reduce(%{}, fn
        {{x1, y}, {x2, y}}, chart ->
          Enum.reduce(x1..x2, chart, fn x, chart ->
            Map.update(chart, {x, y}, 1, &(&1 + 1))
          end)

        {{x, y1}, {x, y2}}, chart ->
          Enum.reduce(y1..y2, chart, fn y, chart ->
            Map.update(chart, {x, y}, 1, &(&1 + 1))
          end)

        {{x1, y1}, {x2, y2}}, chart ->
          x1..x2
          |> Enum.with_index()
          |> Enum.reduce(chart, fn {x, i}, chart ->
            # for 45deg lines y changes by +1/-1
            y = (y2 > y1 && y1 + i) || y1 - i
            Map.update(chart, {x, y}, 1, &(&1 + 1))
          end)
      end)

    chart |> Map.values() |> Enum.count(&(&1 > 1))
  end
end
