defmodule Exercise6 do

  def compute_total do
    tax_rates = [
      NC: 0.075,
      TX: 0.08
    ];

    orders = [
      [ id: 123, ship_to: :NC, net_amount: 100.00 ],
      [ id: 124, ship_to: :OK, net_amount: 35.50 ],
      [ id: 125, ship_to: :TX, net_amount: 24.00 ],
      [ id: 126, ship_to: :TX, net_amount: 44.80 ],
      [ id: 127, ship_to: :NC, net_amount: 25.00 ],
      [ id: 128, ship_to: :MA, net_amount: 10.00 ],
      [ id: 129, ship_to: :CA, net_amount: 102.00 ],
      [ id: 130, ship_to: :NC, net_amount: 50.00 ]
    ];

    compute(tax_rates, orders)
  end

  def compute(tax_rates, orders) do
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
