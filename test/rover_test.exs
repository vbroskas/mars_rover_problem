defmodule RoverTest do
  use ExUnit.Case
  import ExUnit.CaptureIO
  alias Rover

  test "test 1" do
    # test inputs
    '''
    5 5
    1 2 N
    LMLMLMLMM
    3 3 E
    MMRMMRMRRM
    :done
    '''

    assert Rover.get_input() == ["1 3 N", "5 1 E"]
  end

  test "test 2" do
    # test inputs
    '''
    5 5
    1 0 E
    MMMLMMRRMMRRM
    0 0 N
    MMMRMMMLMMRMM
    :done
    '''

    assert Rover.get_input() == ["4 1 N", "5 5 E"]
  end

  test "test process set" do
    assert Rover.process_set(["12N", "LMLMLMLMM"]) == "1 3 N"
    assert Rover.process_set(["33E", "MMRMMRMRRM"]) == "5 1 E"
    assert Rover.process_set(["10E", "MMMLMMRRMMRRM"]) == "4 1 N"
    assert Rover.process_set(["00N", "MMMRMMMLMMRMM"]) == "5 5 E"
  end
end
