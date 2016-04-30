defmodule ParserTest do

  use ExUnit.Case

  import Weather.Parser

  @xml "<?xml version=\"1.0\" encoding=\"ISO-8859-1\"?> \r\n<?xml-stylesheet href=\"latest_ob.xsl\" type=\"text/xsl\"?>\r\n<current_observation version=\"1.0\"\r\n\t xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\"\r\n\t xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\"\r\n\t xsi:noNamespaceSchemaLocation=\"http://www.weather.gov/view/current_observation.xsd\">\r\n\t<credit>NOAA's National Weather Service</credit>\r\n\t<credit_URL>http://weather.gov/</credit_URL>\r\n\t<image>\r\n\t\t<url>http://weather.gov/images/xml_logo.gif</url>\r\n\t\t<title>NOAA's National Weather Service</title>\r\n\t\t<link>http://weather.gov</link>\r\n\t</image>\r\n\t<suggested_pickup>15 minutes after the hour</suggested_pickup>\r\n\t<suggested_pickup_period>60</suggested_pickup_period>\n\t<location>Denton Municipal Airport, TX</location>\n\t<station_id>KDTO</station_id>\n\t<latitude>33.20505</latitude>\n\t<longitude>-97.20061</longitude>\n\t<observation_time>Last Updated on Apr 29 2016, 3:53 pm CDT</observation_time>\r\n        <observation_time_rfc822>Fri, 29 Apr 2016 15:53:00 -0500</observation_time_rfc822>\n\t<weather>Mostly Cloudy</weather>\n\t<temperature_string>77.0 F (25.0 C)</temperature_string>\r\n\t<temp_f>77.0</temp_f>\r\n\t<temp_c>25.0</temp_c>\n\t<relative_humidity>82</relative_humidity>\n\t<wind_string>Northwest at 6.9 MPH (6 KT)</wind_string>\n\t<wind_dir>Northwest</wind_dir>\n\t<wind_degrees>320</wind_degrees>\n\t<wind_mph>6.9</wind_mph>\n\t<wind_kt>6</wind_kt>\n\t<pressure_string>1000.4 mb</pressure_string>\n\t<pressure_mb>1000.4</pressure_mb>\n\t<pressure_in>29.57</pressure_in>\n\t<dewpoint_string>71.1 F (21.7 C)</dewpoint_string>\r\n\t<dewpoint_f>71.1</dewpoint_f>\r\n\t<dewpoint_c>21.7</dewpoint_c>\n\t<visibility_mi>8.00</visibility_mi>\n \t<icon_url_base>http://forecast.weather.gov/images/wtf/small/</icon_url_base>\n\t<two_day_history_url>http://www.weather.gov/data/obhistory/KDTO.html</two_day_history_url>\n\t<icon_url_name>bkn.png</icon_url_name>\n\t<ob_url>http://www.weather.gov/data/METAR/KDTO.1.txt</ob_url>\n\t<disclaimer_url>http://weather.gov/disclaimer.html</disclaimer_url>\r\n\t<copyright_url>http://weather.gov/disclaimer.html</copyright_url>\r\n\t<privacy_policy_url>http://weather.gov/notice.html</privacy_policy_url>\r\n</current_observation>\n"

  test "parses the 'station_id' tag" do
    station_id = Weather.Parser.parse_station_id(@xml)
    assert station_id == "KDTO"
  end

  test "parses the 'weather' tag" do
    weather = Weather.Parser.parse_weather(@xml)
    assert weather == "Mostly Cloudy"
  end

  test "parses the 'temp_c' tag" do
    temp_c = Weather.Parser.parse_temp_c(@xml)
    assert temp_c == "25.0"
  end

  test "parses the 'pressure_mb' tag" do
    pressure_mb = Weather.Parser.parse_pressure_mb(@xml)
    assert pressure_mb  == "1000.4"
  end

  test "returns a 'station_id' key" do
    weather_info = Weather.Parser.parse({:ok, @xml})
    assert weather_info["station_id"] != nil
  end

  test "returns a 'weather' key" do
    weather_info = Weather.Parser.parse({:ok, @xml})
    assert weather_info["weather"] != nil
  end

  test "returns a 'temperature' key" do
    weather_info = Weather.Parser.parse({:ok, @xml})
    assert weather_info["temperature"] != nil
  end

  test "returns a 'pressure' key" do
    weather_info = Weather.Parser.parse({:ok, @xml})
    assert weather_info["pressure"] != nil
  end

end
