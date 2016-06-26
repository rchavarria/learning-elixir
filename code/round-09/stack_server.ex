defmodule Stack.Server do
  use GenServer

  def handle_call(:pop, _from, current_stack) do
    [ first | remaining_stack ] = current_stack
    { :reply, first, remaining_stack }
  end

end
