defmodule Exercise5 do

  # run: elixir -r exercise-04-round-07.exs -e "Exercise4.run"
  def run do
    IO.puts "Parent's PID #{inspect self}"

    Process.flag(:trap_exit, true)
    child_pid = spawn_monitor(Exercise5, :child, [self])
    IO.puts "Child's PID #{inspect child_pid}"

    :timer.sleep(500)

    listen_to_child
  end

  def child(parent_pid) do
    send parent_pid, "Hello!"
    exit(:boom)
    # raise "Child finished"
  end

  def listen_to_child do
    receive do
      msg ->
        IO.puts "Received: #{inspect msg}"
    end

    listen_to_child
  end

end
