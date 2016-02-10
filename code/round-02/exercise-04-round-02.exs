defmodule Exercise4 do

  def caesar([], _), do: []
  def caesar([ head | tail ], n) do
    [ cypher(head, n) | caesar(tail, n) ]
  end

  defp cypher(chr, n) do
    97 + rem(chr + n - 97, 26)
  end

end

