defmodule Exercise1 do

  def fizzbuzz(up_to) do
    1..up_to |> Enum.map(&_fizzbuzz/1)
  end
  
  defp _fizzbuzz(n) do
    case n do
      _ when rem(n, 5) == 0 and rem(n, 3) == 0 -> "FizzBuzz"
      _ when rem(n, 5) == 0 -> "Buzz"
      _ when rem(n, 3) == 0 -> "Fizz"
      _ -> n
    end
  end


end
