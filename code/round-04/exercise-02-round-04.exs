defmodule Exercise2 do

  def anagram?(w1, w2), do: Enum.sort(w1) === Enum.sort(w2)

end
