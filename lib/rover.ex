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
    IO.inspect(result)
    # [["12N", "MMRMMRMRRM"], ["33E", "MMRMMRMLLM"]]
  end

  def step_one() do
  end

  @doc """
  Turn Right functions
  """
  def right({x, y}, :N = direction, "R") do
    # direction now :E
  end

  def right({x, y}, :E = direction, "R") do
    # direction now :S
  end

  def right({x, y}, :S = direction, "R") do
    # direction now :W
  end

  def right({x, y}, :W = direction, "R") do
    # direction now :N
  end

  @doc """
  Turn Left functions
  """
  def left({x, y}, :N = direction, "L") do
    # direction now :W
  end

  def left({x, y}, :E = direction, "L") do
    # direction now :N
  end

  def left({x, y}, :S = direction, "L") do
    # direction now :E
  end

  def left({x, y}, :W = direction, "L") do
    # direction now :S
  end

  @doc """
  Move functions
  """
  def move({x, y}, :N, "M") do
    # y + 1
  end

  def move({x, y}, :E, "M") do
    # x + 1
  end

  def move({x, y}, :S, "M") do
    # y - 1
  end

  def move({x, y}, :W, "M") do
    # x -1
  end
end
