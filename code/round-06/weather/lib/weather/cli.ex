defmodule Weather.CLI do

  require Logger

  @doc """
  This is how you run the application:
    mix run -e 'Weather.CLI.run("KDTO")'
  """
  def run(airport) do
    Logger.info "Running Weather. We'll get #{airport} weather conditions"

    Weather.Service.fetch(airport)
    |> Weather.Parser.parse
    |> Weather.Print.print
  end

end
