# Weather

In the United States, the National Oceanic and Atmospheric Administration provides hourly XML feeds of conditions at 1,800 locations (http://w1.weather.gov/xml/current_obs/). For example, http://w1.weather.gov/xml/current_obs/KDTO.xml.

Write an application that fetches this data, parses it, and displays it in a nice format. (Hint: You might not have to download a library to handle XML parsing.)

# WIP list:

- Format data structure in a table

# TODO list:

- Give the table a nice format

# DONE list:

+ Handle response from weather.gov. :error or :ok, returning just the body
+ Transform XML data into some data structure, such as a hashdict

