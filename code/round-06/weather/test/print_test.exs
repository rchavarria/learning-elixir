defmodule PrintTest do

  use ExUnit.Case

  import Weather.Print

  test "computes max width of a map with one key" do
    weather_info = %{ "a" => "abc" }
    max_width = Weather.Print.compute_max_width(weather_info)
    assert max_width == 3
  end

  test "computes max width of a map with several keys" do
    weather_info = %{ "a" => "abc", "b" => "12345", "c" => "1..4" }
    max_width = Weather.Print.compute_max_width(weather_info)
    assert max_width == 5
  end

end
