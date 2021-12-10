defmodule Aoc.Day4.Part1 do
  @moduledoc """
  Day 4, Part 1
  [Giant Squid](https://adventofcode.com/2021/day/4)
  """
  def bingo(numbers_raw, file) do
    numbers =
      numbers_raw
      |> String.split(",", trim: true)
      |> Enum.map(&String.to_integer/1)

    File.stream!(file)
    |> Stream.map(&String.trim/1)
    |> Stream.chunk_every(5, 6)
    |> Enum.to_list()
    |> Enum.map(&{&1, generate_columns(&1)})
    |> Enum.map(fn {rows, columns} -> {parse_numbers(rows), parse_numbers(columns)} end)
    |> mark_boards(numbers)
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

  def mark_boards(boards_raw, numbers) do
    boards =
      boards_raw
      |> Enum.with_index()
      |> Enum.map(fn {{rows, columns}, board_index} -> {rows ++ columns, board_index} end)

    # loop through each number
    {_, {board_index, last_number}} =
      Enum.reduce_while(numbers, {boards, nil}, fn num, {updated_boards, _} ->
        # loop through each board
        {marked_boards, index} =
          Enum.reduce_while(updated_boards, {[], nil}, fn {rows, index}, {updated_boards, _} ->
            # loop through each row
            {marked_rows, i} =
              Enum.reduce_while(rows, {[], nil}, fn row, {marked, _} ->
                # remove number from row
                marked_row = Enum.reject(row, &(&1 == num))
                # if remains empty row return board index
                if marked_row == [],
                  do: {:halt, {:break, index}},
                  else: {:cont, {marked ++ [marked_row], nil}}
              end)

            if i,
              do: {:halt, {:break, i}},
              else: {:cont, {updated_boards ++ [{marked_rows, index}], nil}}
          end)

        if index, do: {:halt, {:break, {index, num}}}, else: {:cont, {marked_boards, nil}}
      end)

    get_final_score(boards_raw, numbers, board_index, last_number)
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
