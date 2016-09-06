defmodule Stack do
  use Application

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    initial_stack = [ 1, 2, 3, 4, 5 ]

    children = [
      worker(Stack.Server, [ initial_stack ]),
    ]

    opts = [strategy: :one_for_one, name: Stack.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
