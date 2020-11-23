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
    # example: reduce give list of final coord lists: [[3, 3, "E"], [5, 1, "S"]]
  end

  def process_set([starting, instructions]) do
    <<x::binary-size(1), y::binary-size(1), direction::binary-size(1)>> = starting
    instructions = String.graphemes(instructions)
    process_step({x, y}, direction, instructions)
  end

  def process_step({x, y}, direction, nil) do
    [x, y, direction]
  end

  @doc """
  Turn Right functions
  """
  def process_step({x, y}, "N" = direction, [h = "R" | t]) do
    # direction now :E
    # call process_step() with tail
  end

  def process_step({x, y}, "E" = direction, [h = "R" | t]) do
    # direction now :Ss
  end

  def process_step({x, y}, "S" = direction, [h = "R" | t]) do
    # direction now :W
  end

  def process_step({x, y}, "W" = direction, [h = "R" | t]) do
    # direction now :N
  end

  @doc """
  Turn Left functions
  """
  def process_step({x, y}, "N" = direction, [h = "L" | t]) do
    # direction now :W
  end

  def process_step({x, y}, "E" = direction, [h = "L" | t]) do
    # direction now :N
  end

  def process_step({x, y}, "S" = direction, [h = "L" | t]) do
    # direction now :E
  end

  def process_step({x, y}, "W" = direction, [h = "L" | t]) do
    # direction now :S
  end

  @doc """
  Move functions
  """
  def process_step({x, y}, "N", [h = "M" | t]) do
    # y + 1
  end

  def process_step({x, y}, "E", [h = "M" | t]) do
    # x + 1
  end

  def process_step({x, y}, "S", [h = "M" | t]) do
    # y - 1
  end

  def process_step({x, y}, "W", [h = "M" | t]) do
    # x -1
  end
end
