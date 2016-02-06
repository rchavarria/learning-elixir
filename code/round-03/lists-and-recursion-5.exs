defmodule ListsAndRecursion5 do

  def all?([], _), do: true
  def all? [head | tail], predicate do
    if predicate.(head) do
      all?(tail, predicate)
    else
      false
    end
  end

  def each([], _), do: nil
  def each([head | tail], predicate) do
    predicate.(head)
    each(tail, predicate)
  end

  def filter([], _), do: []
  def filter([ head | tail ], predicate) do
    if (predicate.(head)) do
      [ head | filter(tail, predicate) ]
    else
      filter(tail, predicate)
    end
  end

  def take(_, 0), do: []
  def take([ head | tail ], n) do
    [ head | take(tail, n - 1) ]
  end

  def split(collection, n) do
    took = take(collection, n)
    { took, collection -- took }
  end

end

