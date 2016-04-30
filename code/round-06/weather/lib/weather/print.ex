defmodule Weather.Print do

  def print(weather_info) do
    weather_info
    |> IO.inspect
  end

end
