defmodule Exercise3 do

  def calculate(expression) do
    { n1, rest } = parse_number(expression)
    rest = skip_spaces(rest)
    { operation, rest } = parse_operation(rest)
    rest = skip_spaces(rest)
    { n2, _ } = parse_number(rest)

    IO.puts operation.(n1, n2)
  end

  defp parse_number(expression) do
    _parse_number(expression, 0)
  end
  
  defp _parse_number([ digit | tail ], n) when digit in ?0..?9 do
    _parse_number(tail, n * 10 + digit - ?0)
  end
  defp _parse_number(expression, n) do
    { n, expression }
  end

  defp skip_spaces([ character | tail ]) when character === ?\s do
    skip_spaces(tail)
  end
  defp skip_spaces(expression), do: expression

  defp parse_operation([ ?+ | tail ]), do: { &(&1 + &2), tail }
  defp parse_operation([ ?- | tail ]), do: { &(&1 - &2), tail }
  defp parse_operation([ ?* | tail ]), do: { &(&1 * &2), tail }
  defp parse_operation([ ?/ | tail ]), do: { &(div(&1, &2)), tail }

end
