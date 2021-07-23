defmodule RoverTest do
  use ExUnit.Case
  doctest Rover

  test "get_state should return current state" do
    {:ok, _} = Rover.start_link({9, 9, :N, "rover0"})
    {:ok, state} = Rover.get_state("rover0")
    assert state == {9, 9, :N}
  end

  test "handle_cast :go_forward should return updated state" do
    {:noreply, state} = Rover.handle_cast(:go_forward, %Rover{x: 1, y: 3, direction: :N})
    assert state == %Rover{x: 1, y: 4, direction: :N}
  end

  test "handle_cast :go_backward should return updated state" do
    {:noreply, state} = Rover.handle_cast(:go_backward, %Rover{x: 1, y: 3, direction: :N})
    assert state == %Rover{x: 1, y: 2, direction: :N}
  end

  test "handle_cast :rotate_left should return updated state" do
    {:noreply, state} = Rover.handle_cast(:rotate_left, %Rover{x: 1, y: 3, direction: :N})
    assert state == %Rover{x: 1, y: 3, direction: :W}
  end

  test "handle_cast :rotate_right should return updated state" do
    {:noreply, state} = Rover.handle_cast(:rotate_right, %Rover{x: 1, y: 3, direction: :N})
    assert state == %Rover{x: 1, y: 3, direction: :E}
  end
end
