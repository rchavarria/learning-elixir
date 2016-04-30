defmodule Weather.Print do

  def print(weather_info) do
    max_data_width = compute_max_width(weather_info)

    IO.puts "+---------------------+-#{String.duplicate("-", max_data_width)}-+"
    IO.puts "+                     + #{String.ljust("Values", max_data_width)} +"
    IO.puts "+---------------------+-#{String.duplicate("-", max_data_width)}-+"
    IO.puts "+     Station id      + #{String.ljust(weather_info["station_id"], max_data_width)} +"
    IO.puts "+       Weather       + #{String.ljust(weather_info["weather"], max_data_width)} +"
    IO.puts "+     Temperature     + #{String.rjust(weather_info["temperature"], max_data_width)} +"
    IO.puts "+      Pressure       + #{String.rjust(weather_info["pressure"], max_data_width)} +"
    IO.puts "+---------------------+-#{String.duplicate("-", max_data_width)}-+"
  end

  def compute_max_width(weather_info) do
    weather_info
    |> Dict.values
    |> Enum.map(&(String.length(&1)))
    |> Enum.max
  end

end
