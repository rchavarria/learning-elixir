defmodule Exercise1 do

  def span(to, to), do: [ to ]
  def span(from, to), do: [ from | span(from + 1, to) ]

  def list_primes(up_to) do
    for x <- span(2, up_to), is_prime(x), do: x
  end

  def is_prime(n) do
    primes = for x <- 2..n, rem(n, x) == 0, do: x
    1 == Enum.count primes
  end

end
