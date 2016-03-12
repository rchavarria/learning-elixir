defmodule Exercise6 do

  def parse do
    tax_rates = [
      NC: 0.075,
      TX: 0.08
    ];

    {:ok, file} = File.open("code/round-04/taxes.csv", [ :read, :utf8 ])
    as_stream = IO.stream file, :line
    columns_skipped = Stream.drop as_stream, 1
    as_fields = Enum.map columns_skipped, fn line ->
      [ id, state, tax ] = String.split line, ","

      id_as_integer = String.to_integer(id)
      state_as_atom = String.to_atom(String.slice(state, 1..-1))
      tax_as_float = String.to_float(String.strip(tax))

      [ id: id_as_integer, ship_to: state_as_atom, net_amount: tax_as_float ]
    end
    
    computed = _compute(tax_rates, as_fields)
    Enum.each computed, &IO.inspect/1
  end

  defp _compute(tax_rates, orders) do
    for state <- Keyword.keys(tax_rates),
        order <- orders,
        state == Keyword.get(order, :ship_to) do
      rate = Keyword.get(tax_rates, state)
      net = Keyword.get(order, :net_amount)
      amount = net + net * rate

      Keyword.put(order, :total_amount, amount)
    end
  end

end
