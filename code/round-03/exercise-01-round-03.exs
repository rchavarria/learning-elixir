defmodule Exercise1 do

  def span(to, to), do: [ to ]
  def span(from, to), do: [ from | span(from + 1, to) ]

  def list_primes(up_to) do
    for x <- span(2, up_to), is_prime(x), do: x
  end

  def is_prime(2), do: true
  def is_prime(3), do: true
  def is_prime(5), do: true
  def is_prime(7), do: true
  def is_prime(11), do: true
  def is_prime(13), do: true
  def is_prime(n) when rem(n, 2) == 0, do: false
  def is_prime(n) when rem(n, 3) == 0, do: false
  def is_prime(n) when rem(n, 5) == 0, do: false
  def is_prime(n) when rem(n, 7) == 0, do: false
  def is_prime(n) when rem(n, 11) == 0, do: false
  def is_prime(n) when rem(n, 13) == 0, do: false
  def is_prime(n), do: true

end
