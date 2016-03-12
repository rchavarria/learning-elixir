defmodule Exercise5 do

  def capitalize_senteces(dqs) do
    sentences = String.split dqs, ". "
    capitalized = Enum.map sentences, &String.capitalize/1
    Enum.join capitalized, ". "
  end

end
