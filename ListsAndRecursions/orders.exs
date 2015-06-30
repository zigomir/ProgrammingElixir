# Exercise: ListsAndRecursion-8
defmodule Orders do

  @orders [
    [ id: 123, ship_to: :NC, net_amount: 100.00 ],
    [ id: 124, ship_to: :OK, net_amount:  35.50 ],
    [ id: 125, ship_to: :TX, net_amount:  24.00 ],
    [ id: 126, ship_to: :TX, net_amount:  44.80 ],
    [ id: 127, ship_to: :NC, net_amount:  25.00 ],
    [ id: 128, ship_to: :MA, net_amount:  10.00 ],
    [ id: 129, ship_to: :CA, net_amount: 102.00 ],
    [ id: 130, ship_to: :NC, net_amount:  50.00 ]
  ]

  # Dayum, why it won't work with module attribute?
  # @tax_rates [ NC: 0.075, TX: 0.08 ]

  def calculate_total_amounts do
    tax_rates = [ NC: 0.075, TX: 0.08 ]

    for order <- @orders do
      tax = 0
      if Keyword.has_key?(tax_rates, order[:ship_to]) do
        tax = tax_rates[order[:ship_to]]
      end

      Keyword.put(order, :total_amount, order[:net_amount] * (1 + tax))
     end
  end

end
