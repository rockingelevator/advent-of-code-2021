defmodule Aoc.Day4.Part2 do
  @moduledoc """
  Day 4, Part 2
  [Giant Squid](https://adventofcode.com/2021/day/4)
  """
  def bingo(numbers_raw, file) do
    numbers =
      numbers_raw
      |> String.split(",", trim: true)
      |> Enum.map(&String.to_integer/1)

    boards_raw =
      File.stream!(file)
      |> Stream.map(&String.trim/1)
      |> Stream.chunk_every(5, 6)
      |> Enum.to_list()
      |> Enum.map(&{&1, generate_columns(&1)})
      |> Enum.map(fn {rows, columns} -> {parse_numbers(rows), parse_numbers(columns)} end)

    boards =
      boards_raw
      |> Enum.with_index()
      |> Enum.map(fn {{rows, columns}, board_index} -> {rows ++ columns, board_index} end)

    {index, number} = mark(numbers, boards)
    get_final_score(boards_raw, numbers, index, number)
  end

  defp parse_numbers(rows) do
    rows
    |> Enum.map(&String.split(&1, " ", trim: true))
    |> Enum.map(&parse_line/1)
  end

  defp parse_line(l) do
    Enum.map(l, &String.to_integer/1)
  end

  defp generate_columns(rows) do
    rows
    |> Enum.reduce([], fn row, acc ->
      chars = String.split(row, " ", trim: true)

      if acc == [] do
        chars
      else
        acc
        |> Enum.with_index()
        |> Enum.map(fn {r, index} -> r <> " " <> Enum.at(chars, index) end)
      end
    end)
  end

  defp mark(numbers, boards), do: mark(numbers, {nil, nil}, boards)
  defp mark([], {index, number}, _), do: {index, number}
  defp mark(_, {index, number}, []), do: {index, number}

  defp mark([num | tail], {previous_win_index, previous_win_number}, boards) do
    {updated_boards, b_index, b_number} =
      Enum.reduce(boards, {[], previous_win_index, previous_win_number}, fn {rows, i},
                                                                            {marked_rows, b_i,
                                                                             b_n} ->
        {bingo_index, bingo_number, updated_rows} =
          Enum.reduce_while(rows, {nil, nil, []}, fn row, {_, _, marked_rows} ->
            r = Enum.reject(row, &(&1 == num))
            if r == [], do: {:halt, {i, num, nil}}, else: {:cont, {nil, nil, marked_rows ++ [r]}}
          end)

        if bingo_index do
          {marked_rows, bingo_index, bingo_number}
        else
          {marked_rows ++ [{updated_rows, i}], b_i, b_n}
        end
      end)

    mark(tail, {b_index, b_number}, updated_boards)
  end

  defp get_final_score(boards_raw, numbers, board_index, last_number) do
    {n, _} = Enum.split_while(numbers, &(&1 != last_number))
    win_nums = n ++ [last_number]
    {rows, _} = Enum.at(boards_raw, board_index)

    score =
      Enum.reduce(rows, 0, fn row, acc_total ->
        s =
          row
          |> Enum.reject(&Enum.member?(win_nums, &1))
          |> Enum.sum()

        s + acc_total
      end)

    score * last_number
  end
end
