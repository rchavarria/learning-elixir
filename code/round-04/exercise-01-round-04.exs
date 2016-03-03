defmodule Exercise1 do

  def is_printable?([]), do: true
  def is_printable?([ head | _ ]) when head < ?\s, do: false
  def is_printable?([ head | _ ]) when head > ?~, do: false
  def is_printable?([ _ | tail ]) do
    is_printable?(tail)
  end
  
  def daves_is_printable?(string) do
    # check all elements in `string` are in the range from
    # \s (space) to ~
    Enum.all? string, &(&1 in ?\s..?~)
  end

end
