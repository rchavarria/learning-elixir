# En un proyecto creado con `mix`, ir a la raíz y ejecutar el comando
#   iex -S mix
# Compilará el proyecto y arrancará la aplicación
#
# Para ir haciendo llamadas al servidor:
#   iex> GenServer.pop
#   iex> GenServer.push <número>
#
defmodule Stack do
  use Application

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    initial_stack = Application.get_env(:stack, :initial_stack)

    children = [
      worker(Stack.Server, [ initial_stack ]),
    ]

    opts = [strategy: :one_for_one, name: Stack.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
