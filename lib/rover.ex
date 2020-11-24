defmodule Rover do
  @moduledoc """
  get line inputs, put them in list, throw out first element (top right cords)
  chunk list by every two elements to get pairs of [starting_coords, sequence]

  """

  def get_input() do
    input =
      IO.stream(:stdio, :line)
      |> Stream.take_while(&(&1 != ":done\n"))
      |> Enum.to_list()
      |> Enum.map(fn x -> String.trim(x) end)
      |> Enum.map(fn x -> String.replace(x, " ", "") end)

    [_h | t] = input
    result = Enum.chunk_every(t, 2)
    # result example = [["12N", "MMRMMRMRRM"], ["33E", "MMRMMRMLLM"]]
    Enum.reduce(result, [], fn set, acc -> [process_set(set) | acc] end)
    |> Enum.reverse()

    # example: reduce give list of final coord lists: [[3 3 E], [5 1 S]]
  end

  def process_set([starting, instructions]) do
    <<x::binary-size(1), y::binary-size(1), direction::binary-size(1)>> = starting
    instructions = String.graphemes(instructions)
    process_step({String.to_integer(x), String.to_integer(y)}, direction, instructions)
  end

  def process_step({x, y}, direction, []) do
    "#{x} #{y} #{direction}"
  end

  @doc """
  Turn Right functions
  """
  def process_step({x, y}, "N", [_h = "R" | t]) do
    # direction now :E
    # call process_step() with tail
    process_step({x, y}, "E", t)
  end

  def process_step({x, y}, "E", [_h = "R" | t]) do
    # direction now :S
    process_step({x, y}, "S", t)
  end

  def process_step({x, y}, "S", [_h = "R" | t]) do
    # direction now :W
    process_step({x, y}, "W", t)
  end

  def process_step({x, y}, "W", [_h = "R" | t]) do
    # direction now :N
    process_step({x, y}, "N", t)
  end

  @doc """
  Turn Left functions
  """
  def process_step({x, y}, "N", [_h = "L" | t]) do
    # direction now :W
    process_step({x, y}, "W", t)
  end

  def process_step({x, y}, "E", [_h = "L" | t]) do
    # direction now :N
    process_step({x, y}, "N", t)
  end

  def process_step({x, y}, "S", [_h = "L" | t]) do
    # direction now :E
    process_step({x, y}, "E", t)
  end

  def process_step({x, y}, "W", [_h = "L" | t]) do
    # direction now :S
    process_step({x, y}, "S", t)
  end

  @doc """
  Move functions
  """
  def process_step({x, y}, "N", [_h = "M" | t]) do
    # y + 1
    process_step({x, y + 1}, "N", t)
  end

  def process_step({x, y}, "E", [_h = "M" | t]) do
    # x + 1
    process_step({x + 1, y}, "E", t)
  end

  def process_step({x, y}, "S", [_h = "M" | t]) do
    # y - 1
    process_step({x, y - 1}, "S", t)
  end

  def process_step({x, y}, "W", [_h = "M" | t]) do
    # x -1
    process_step({x - 1, y}, "W", t)
  end
end
