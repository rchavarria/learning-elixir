defmodule Weather.Service do

  require Logger

  def fetch(airport) do
    Logger.info "Fetching info about airport #{airport}"
    "http://w1.weather.gov/xml/current_obs/#{airport}.xml"
    |> HTTPoison.get
    |> handle_response
  end
  
  def handle_response({:ok, %{status_code: 200, body: body}}) do
    Logger.info "Response :ok"
    {:ok, body}
  end
  def handle_response({:ok, %{status_code: _, body: body}}) do
    Logger.info "Response :error"
    {:error, body}
  end
  def handle_response({:error, body}) do
    Logger.error "Something wrong happened fetching data"
    System.halt(2)
  end

end
