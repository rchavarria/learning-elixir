defmodule Exercise3 do

  def max([ head | tail ]), do: _max(tail, head)

  defp _max([], maximum), do: maximum
  defp _max([ head | tail ], maximum) when head >= maximum do
    _max(tail, head)
  end
  defp _max([ head | tail ], maximum) when head < maximum do
    _max(tail, maximum)
  end

end
