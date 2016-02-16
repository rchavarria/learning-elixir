defmodule Exercise1 do

  def is_printable([]), do: true
  def is_printable([ head | _ ]) when head < ?a, do: false
  def is_printable([ head | _ ]) when head > ?z, do: false
  def is_printable([ _ | tail ]) do
    is_printable(tail)
  end

end
