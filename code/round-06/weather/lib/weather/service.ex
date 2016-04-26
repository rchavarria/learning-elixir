defmodule Weather.Service do

  require Logger

  def fetch(airport) do
    Logger.info "Fetching info about airport #{airport}"
    "http://w1.weather.gov/xml/current_obs/#{airport}.xml"
    |> HTTPoison.get
  end
  
end
