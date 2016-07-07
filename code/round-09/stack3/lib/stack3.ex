# En un proyecto creado con `mix`, ir a la raíz y ejecutar el comando
#   iex -S mix
# Compilará el proyecto y nos permitirá ejecutar código.
#
# Para arrancar el servidor:
#   iex> { :ok, pid } = GenServer.start_link(Stack.Server, [ 1, 2, 3 ], name: :stack)
# Donde [ 1, 2, 3 ] es el estado inicial del servidor y `:stack` es el nombre del
# servidor, para poder llamarle sin utilizar su PID
#
# Para ir haciendo llamadas al servidor:
#   iex> GenServer.call(:stack, :pop)
#   iex> GenServer.cast(:stack, { :push, 1234 })
#
defmodule Stack.Server do
  use GenServer

  # API

  def start_link(initial_stack) do
    # the second __MODULE__ tells GenServer to use the name of this module as the name for the process
    GenServer.start_link(__MODULE__, initial_stack, name: __MODULE__)
  end

  def pop(), do: GenServer.call(__MODULE__, :pop)
  def push(new_item), do: GenServer.cast(__MODULE__, { :push, new_item })

  def handle_call(:pop, _from, current_stack) do
    [ first | remaining_stack ] = current_stack
    { :reply, first, remaining_stack }
  end

  def handle_cast({ :push, new_element }, current_stack) do
    { :noreply, [ new_element | current_stack ] }
  end

end
