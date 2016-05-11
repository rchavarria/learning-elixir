defmodule Chain do

  # para ejecutar el programa:
  #   elixir -r chain.exs -e "Chain.run(100)"
  #   elixir --erl "+P 1000000" -r chain.exs -e "Chain.run(100)"
  def run(n) do
    # :timer.tc es una librería de Erlang que mide tiempos de 
    # procesamiento de una función. La sintaxis sería:
    #   :timer.tc(<module>, <function>, <function params>)
    IO.puts inspect :timer.tc(Chain, :create_processes, [ n ])
  end

  def create_processes(n) do
    last = Enum.reduce 1..n, self,
        fn (_, send_to) ->
          next_pid = spawn(Chain, :counter, [ send_to ])
          next_pid
        end

    # comienza la cuenta atrás, mandamos el primer mensaje al último
    # proceso creado
    send last, 0

    # y quedamos a la espera de que el primer proceso creado nos envía
    # el resultado
    receive do
      final_count when is_integer(final_count) ->
        "Result is #{inspect(final_count)}."
      end
  end

  def counter(next_pid) do
    receive do
      n ->
        send next_pid, n + 1
    end
  end

end
