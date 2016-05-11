defmodule Exercise4 do

  # run: elixir -r exercise-04-round-07.exs -e "Exercise4.run"
  def run do
    IO.puts "Parent's PID #{inspect self}"

    Process.flag(:trap_exit, true)
    child_pid = spawn_link(Exercise4, :child, [self])
    IO.puts "Child's PID #{inspect child_pid}"

    :timer.sleep(500)

    listen_to_child
  end

  def child(parent_pid) do
    :timer.sleep(100)
    send parent_pid, "Hello!"
    raise "Child finished"
  end

  def listen_to_child do
    receive do
      msg ->
        IO.puts "Received: #{inspect msg}"
    end

    listen_to_child
  end

end
