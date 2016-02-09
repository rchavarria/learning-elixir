defmodule Game do

  def guess(current, first..last) when current > div(first + last, 2) do
    IO.puts "Is it #{div(first + last, 2)}?"
    guess(current, div(first + last, 2)..last)
  end
  def guess(current, first..last) when current < div(first + last, 2) do
    IO.puts "Is it #{div(first + last, 2)}?"
    guess(current, first..div(first + last, 2))
  end
  def guess(current, first..last) when current == div(first + last, 2) do
    IO.puts "Definitely, it is #{current}"
  end

end
