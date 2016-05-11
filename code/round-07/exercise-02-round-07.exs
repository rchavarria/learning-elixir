defmodule Tokens do

  # ejecutar así:
  #   elixir -r exercise-02-round-07.exs -e "Tokens.run"
  def run do
    first = spawn(Tokens, :a_process, [])
    second = spawn(Tokens, :a_process, [])

    send first, { self, "pepito" }
    send second, { self, "fulanito" }

    listen_tokens 0
  end

  def a_process do
    receive do
      { pid, token } ->
        send pid, token
    end
  end

  def listen_tokens(iteration) when iteration <= 1 do
    receive do 
      echoed ->
        IO.puts "Received #{echoed}."
    end

    listen_tokens iteration + 1
  end
  def listen_tokens(iteration) do
    IO.puts "End"
  end

end
