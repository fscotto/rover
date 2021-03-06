defmodule RoverController do
  @world_width Application.get_env(:rover, :world_width)
  @world_height Application.get_env(:rover, :world_height)

  def create_rover(name, x, y, d) do
    RoverSupervisor.create_rover(name, x, y, d)
  end

  def create_multiple_rovers(count) do
    dirs = [:N, :E, :S, :W]

    Enum.each(1..count, fn x ->
      RoverSupervisor.create_rover(
        get_rover_name(x),
        Enum.random(0..@world_width),
        Enum.random(0..@world_height),
        Enum.at(dirs, Enum.random(0..3))
      )
    end)
  end

  def simulate(iterations, rover_count) do
    Enum.each(0..iterations, fn _ ->
      n = Enum.random(1..rover_count)
      rover = get_rover_name(n)
      command = get_random_command()
      send_command(rover, command)
      # Process.sleep(100)
    end)
  end

  def send_multiple_commands(rover_count, command_count \\ 1) do
    Enum.each(0..command_count, fn _ -> send_single_command(rover_count) end)
  end

  defp send_single_command(rover_count) do
    Enum.each(0..rover_count, fn n ->
      send_command(get_rover_name(n), get_random_command())
    end)
  end

  def send_command(name, :F) do
    Rover.go_forward(name)
  end

  def send_command(name, :B) do
    Rover.go_backward(name)
  end

  def send_command(name, :L) do
    Rover.rotate_left(name)
  end

  def send_command(name, :R) do
    Rover.rotate_right(name)
  end

  # More priority to F so we have multiple F commands
  defp get_random_command do
    [:F, :B, :L, :R, :F, :F, :F, :F, :F, :F, :F, :F, :F, :F, :F, :F, :F, :F, :F, :F, :F, :F]
    |> Enum.random()
  end

  defp get_rover_name(n) do
    "rover_#{Integer.to_string(n)}"
  end
end
