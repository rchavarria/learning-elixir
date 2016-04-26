defmodule Weather.CLI do

  require Logger

  @doc """
  This is how you run the application:
    mix run -e 'Weather.CLI.run()'
  """
  def run() do
    Logger.info "Running Weather. We'll get KDTO weather conditions"

    Weather.Service.fetch("KDTO")
    |> print
  end

  defp print(data) do
    Logger.info "Printing data:"
    IO.inspect data
  end

end
