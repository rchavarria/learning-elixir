defmodule RingTicker do
  
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
    IO.puts "Clients are: #{inspect clients}"

    receive do
      { :register, pid } ->
        IO.puts "Registering #{inspect pid}"
        add_client_to_ring(clients, pid)
      end
  end
  
  defp add_client_to_ring(clients, current) do
    first = List.first clients
    last = List.last clients

    IO.puts "Current: #{inspect current}, First: #{inspect first}, Last: #{inspect last}"
    link_source_with_target(first, current)
    link_source_with_target(current, last)

    send_first_tick(clients, current)

    generator([ current | clients ])
  end

  defp link_source_with_target(nil, target), do: link_source_with_target(target, target) 
  defp link_source_with_target(source, nil), do: link_source_with_target(source, source) 
  defp link_source_with_target(source, target) do
    send source, { :next, target }
  end

  defp send_first_tick([], current) do
    IO.puts "First tick is sent"
    send current, { :tick }
  end
  defp send_first_tick(_, current) do
    IO.puts "send_first_tick do nothing"
  end

end

defmodule Client do

  @interval 2000

  def start do
    pid = spawn(__MODULE__, :receiver, [ nil ])
    RingTicker.register(pid)
  end

  def receiver(next_to_tick) do
    receive do
      { :next, next_in_the_ring } ->
        IO.puts "Next in the ring will be #{inspect next_in_the_ring}"
        receiver(next_in_the_ring)

      { :tick } ->
        IO.puts "Tock"
        send_tick_to(next_to_tick)
    end
  end

  defp send_tick_to(nil) do
    IO.puts "Nobody to send tick"
    receiver(nil)
  end
  defp send_tick_to(next) do
    :timer.sleep(@interval)
    send next, { :tick }
    receiver(next)
  end

end

