# Day 5, Hydrothermal Venture
# Part 1

defmodule Vents do
  def go(file) do
    points =
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
      # get only vertical or horizontal lines
      |> Enum.filter(fn {{x_start, y_start}, {x_end, y_end}} ->
        x_start == x_end || y_start == y_end
      end)
      # makes sure that all lines are drawn from left to right, top to bottom order
      |> Enum.map(fn
        {{x_start, y}, {x_end, y}} when x_start <= x_end -> {{x_start, y}, {x_end, y}}
        {{x_start, y}, {x_end, y}} when x_start > x_end -> {{x_end, y}, {x_start, y}}
        {{x, y_start}, {x, y_end}} when y_start <= y_end -> {{x, y_start}, {x, y_end}}
        {{x, y_start}, {x, y_end}} when y_start > y_end -> {{x, y_end}, {x, y_start}}
      end)

    chart =
      for _ <- 0..999 do
        row = nil
        for _ <- 0..999, do: 0
      end

    chart =
      chart
      |> Enum.with_index()
      |> Enum.map(fn {row, row_index} ->
        row
        |> Enum.with_index()
        |> Enum.map(fn {el, i} ->
          lines_count =
            points
            |> Enum.filter(fn {{x_start, y_start}, {x_end, y_end}} ->
              # element lies on the horizontal line
              # or elementt lies on vertical line
              (y_start == y_end && row_index == y_end && i >= x_start && i <= x_end) ||
                (x_start == x_end && i == x_end && row_index >= y_start && row_index <= y_end)
            end)
            |> Enum.count()
        end)
      end)

    # count chart points with overlaping lines on them
    chart
    |> Enum.reduce(0, fn row, total ->
      count = row |> Enum.filter(&(&1 >= 2)) |> Enum.count()
      total + count
    end)
  end
end
