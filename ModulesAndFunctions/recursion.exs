defmodule Recursion do
  def sum(1), do: 1
  def sum(n) do
    n + sum(n - 1)
  end

  def gdc(x, 0), do: x
  def gdc(x, y) do
    gdc(y, rem(x, y))
  end
end
