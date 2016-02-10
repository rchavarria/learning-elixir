defmodule Exercise2 do

  def mapsum([ head | [] ], func), do: func.(head)
  def mapsum([ head | tail ], func) do
    func.(head) + mapsum(tail, func)
  end

end
