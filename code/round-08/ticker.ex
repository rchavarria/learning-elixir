defmodule Ticker do
  
  @interval 2000
  @name :ticker

  def start do
    # lanza un proceso que hará de servidor
    pid = spawn(__MODULE__, :generator, [[]])
    # registra el PID del servidor para que los clientes sean capaces de
    #encontrarlo y registrase para recibir notificaciones del servidor
    :global.register_name(@name, pid)
  end

  def register(client_pid) do
    server_pid = :global.whereis_name(@name)
    send server_pid, { :register, client_pid }
  end

  def generator(clients) do
    receive do
      { :register, pid } ->
        IO.puts "Registering #{inspect pid}"
        generator([ pid | clients ])

      after @interval ->
        IO.puts "tick"
        Enum.each(clients, fn client ->
          send client, { :tick }
        end)
        generator(clients)
      end
  end

end

defmodule Client do

  def start do
    pid = spawn(__MODULE__, :receiver, [])
    RoundRobinTicker.register(pid)
  end

  def receiver do
    receive do
      { :tick } ->
        IO.puts "Tock in client"
        receiver
    end
  end

end

defmodule RoundRobinTicker do
  
  @interval 2000
  @name :round_robin_ticker

  def start do
    pid = spawn(__MODULE__, :generator, [[]])
    :global.register_name(@name, pid)
  end

  def register(client_pid) do
    server_pid = :global.whereis_name(@name)
    send server_pid, { :register, client_pid }
  end

  def generator(clients) do
    receive do
      { :register, pid } ->
        IO.puts "Registering #{inspect pid}"
        generator([ pid | clients ])

      after @interval ->
        # toma el último de la lista
        last = List.last clients
        remaining_clients = List.delete(clients, last)
        send_tick_to(last)
        # lo pone al principio de forma que los demás sean notificados
        #uno a uno
        generator([ last | remaining_clients ])
      end
  end

  defp send_tick_to(nil), do: nil
  defp send_tick_to(pid) do
    IO.puts "sending tick to #{inspect pid}"
    send pid, { :tick }
  end

end
