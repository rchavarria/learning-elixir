defmodule Exercise4 do

  def center(dqs_list) do
    lengths = Enum.map dqs_list, &String.length/1
    max_length = Enum.max lengths

    centered_list = Enum.map dqs_list, &(_center_string &1, max_length)
    Enum.each centered_list, &IO.puts/1
  end

  defp _center_string(dqs, max_lenght) do
    pad = div((max_lenght - String.length dqs), 2)
    String.rjust dqs, (String.length dqs) + pad
  end

end
