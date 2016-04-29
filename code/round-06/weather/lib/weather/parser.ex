defmodule Weather.Parser do

  require Logger

  def parse({:ok, xml}) do
    Logger.info "XML code got correctly"
    station_id = parse_station_id(xml)
    weather = parse_weather(xml)
    temp_c = parse_weather(xml)
    # extract pressure_mb
    
    xml
  end
  def parse({:error, error}) do
    Logger.error "Error passed to parser function"
    System.halt(1)
  end

  def parse_station_id(xml) do
    re = ~r/.*<station_id>(?<station_id>.*)<\/station_id>.*/
    captures = Regex.named_captures(re, xml)
    captures["station_id"]
  end

  def parse_weather(xml) do
    re = ~r/.*<weather>(?<weather>.*)<\/weather>.*/
    captures = Regex.named_captures(re, xml)
    captures["weather"]
  end

  def parse_temp_c(xml) do
    re = ~r/.*<temp_c>(?<temp_c>.*)<\/temp_c>.*/
    captures = Regex.named_captures(re, xml)
    captures["temp_c"]
  end

end
