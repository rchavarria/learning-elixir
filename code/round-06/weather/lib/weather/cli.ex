defmodule Weather.CLI do

  require Logger

  @doc """
  This is how you run the application:
    mix run -e 'Weather.CLI.run()'
  """
  def run() do
    Logger.info "Running Weather. We'll get KDTO weather conditions"

    Weather.Service.fetch("KDTO")
    |> parse_xml
    |> print
  end

  defp parse_xml({:ok, body}), do: body
  defp parse_xml({:error, body}) do
    Logger.error "Error fetching data"
    System.halt(2)
  end

  defp print(data) do
    Logger.info "Printing data:"
    IO.inspect data
  end

end
