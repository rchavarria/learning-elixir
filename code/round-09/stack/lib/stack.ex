# En un proyecto creado con `mix`, ir a la raíz y ejecutar el comando
#   iex -S mix
# Compilará el proyecto y nos permitirá ejecutar código.
#
# Para arrancar el servidor:
#   iex> { :ok, pid } = GenServer.start_link(Stack.Server, [ 1, 2, 3 ])
# Donde [ 1, 2, 3 ] es el estado inicial del servidor
#
# Para ir haciendo llamadas al servidor:
#   iex> GenServer.call(pid, :pop)
#
defmodule Stack.Server do
  use GenServer

  def handle_call(:pop, _from, current_stack) do
    [ first | remaining_stack ] = current_stack
    { :reply, first, remaining_stack }
  end

end
