# Find 273 with bisect:
#
# (1 + 1000)  / 2 = 500 -> down
# (1 + 500)   / 2 = 250 -> up (move to first)
# (250 + 500) / 2 = 375 -> down
# (250 + 375) / 2 = 312 -> down
# (250 + 312) / 2 = 281 -> down
# (250 + 281) / 2 = 265 -> up (move to first)
# (265 + 281) / 2 = 273 -> WAW
#
# down -> right aka value < last_calc
# up -> left aka value > last_calc

defmodule Bisect do

  def guess(value, first .. last) do
    calc(value, first .. last, div(last, 2))
  end

  defp calc(value, _, current_guess) when value === current_guess do
    IO.puts "Is it #{current_guess}"
    current_guess
  end

  defp calc(value, first .. _, current_guess) when current_guess > value do
    IO.puts "Is it #{current_guess}"
    calc(value, first .. current_guess, div(first + current_guess, 2))
  end

  defp calc(value, _ .. last, current_guess) when current_guess < value do
    IO.puts "Is it #{current_guess}"
    calc(value, current_guess .. last, div(current_guess + last, 2))
  end
end

# Bisect.guess(273, 1..1000)
