defmodule Sequence.Stash do
  use GenServer

  def start_link(current_number) do
    { :ok, _pid } = GenServer.start_link(__MODULE__, current_number)
  end

  # external API
  def get_value(pid) do
    GenServer.call pid, :get_value
  end
  def save_value(pid, new_value) do
    GenServer.cast pid, { :save_value, new_value }
  end

  
  # GenServer implementation

  def handle_call(:get_value, _from, current_number) do
    { :reply, current_number, current_number }
  end
  def handle_cast({ :save_value, new_value }, _current_value) do
    { :noreply, new_value }
  end

end
