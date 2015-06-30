defmodule Sum do

  # with carrying partial total
  # def sum(list), do: _sum(list, 0)
  # defp _sum([], total), do: total
  # defp _sum([head | tail], total), do: _sum(tail, head + total)

  # without
  def sum([]), do: 0
  def sum([head | tail]), do: sum(tail) + head

end
