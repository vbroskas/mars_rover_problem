defmodule Rover do
  @moduledoc """
  get line inputs, put them in list, throw out first element (top right cords)
  chunk list by every two elements to get pairs of [starting_coords, sequence], process each pair
  """
  def get_input() do
    input =
      IO.stream(:stdio, :line)
      |> Stream.take_while(&(&1 != ":done\n"))
      |> Enum.to_list()
      |> Enum.map(fn x -> String.replace(x, ~r/[[:space:]]/, "") end)

    # Top right coords don't matter since we can assume (based on the problem description) that any move
    # will keep a rover within the boundaries of the plateau.
    # HOWEVER, if we do need to check for the rover going out of bounds then I'd need to keep the first
    # element in 'input' (h) and implement checks when the rover moves (Ill add this at some point)
    [_h | t] = input

    Enum.chunk_every(t, 2)
    |> Enum.reduce([], fn set, acc -> [process_set(set) | acc] end)
    |> Enum.reverse()
  end

  def process_set([
        <<x::binary-size(1), y::binary-size(1), direction::binary-size(1)>>,
        instructions
      ]) do
    instructions = String.graphemes(instructions)
    process_step({String.to_integer(x), String.to_integer(y)}, direction, instructions)
  end

  # Base case
  def process_step({x, y}, direction, []) do
    "#{x} #{y} #{direction}"
  end

  # Turn Right
  def process_step({x, y}, "N", [_h = "R" | t]) do
    process_step({x, y}, "E", t)
  end

  def process_step({x, y}, "E", [_h = "R" | t]) do
    process_step({x, y}, "S", t)
  end

  def process_step({x, y}, "S", [_h = "R" | t]) do
    process_step({x, y}, "W", t)
  end

  def process_step({x, y}, "W", [_h = "R" | t]) do
    process_step({x, y}, "N", t)
  end

  # Turn Left
  def process_step({x, y}, "N", [_h = "L" | t]) do
    process_step({x, y}, "W", t)
  end

  def process_step({x, y}, "E", [_h = "L" | t]) do
    process_step({x, y}, "N", t)
  end

  def process_step({x, y}, "S", [_h = "L" | t]) do
    process_step({x, y}, "E", t)
  end

  def process_step({x, y}, "W", [_h = "L" | t]) do
    process_step({x, y}, "S", t)
  end

  # Move functions
  def process_step({x, y}, "N", [_h = "M" | t]) do
    process_step({x, y + 1}, "N", t)
  end

  def process_step({x, y}, "E", [_h = "M" | t]) do
    process_step({x + 1, y}, "E", t)
  end

  def process_step({x, y}, "S", [_h = "M" | t]) do
    process_step({x, y - 1}, "S", t)
  end

  def process_step({x, y}, "W", [_h = "M" | t]) do
    process_step({x - 1, y}, "W", t)
  end
end
