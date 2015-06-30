require IEx

defmodule MyList do

  def mapsum(list, func) do
    _mapsum(list, func) |> _sum
  end

  defp _mapsum([], _func), do: []
  defp _mapsum([head | tail], func) do
    [func.(head) | _mapsum(tail, func)]
  end

  defp _sum([]), do: 0
  defp _sum([head | tail]), do: _sum(tail) + head

  # MAXI!!!
  def max(list), do: _max(list, 0)

  defp _max([], currently_largest), do: currently_largest
  defp _max([head | tail], currently_largest) when currently_largest > head do
    _max(tail, currently_largest)
  end

  defp _max([head | tail], currently_largest) when currently_largest <= head do
    _max(tail, head)
  end

  # Waat?
  # Calling it with '' aka single quotes which means list of characters
  def caesar([], _n), do: []
  def caesar([head | _tail], n) when head + n > 'z' do
    # [head + n | caesar(tail)]
    IO.puts "Wrapping now, but what is wrapping here? :)"
  end
  def caesar([head | tail], n) do
    [head + n | caesar(tail, n)]
  end

  def span(from, to) when from === to, do: [from]
  def span(from, to) when from < to do
    [from] ++ span(from + 1, to)
  end

  # Exercise: ListsAndRecursion-5
  def all?([], _func), do: true
  def all?([head | tail], func) do
    func.(head) && all?(tail, func)
  end

  def each([], _func), do: :ok
  def each([head | tail], func) do
    func.(head)
    each(tail, func)
  end

  def filter([], _func), do: []
  def filter([head | tail], func) do
    if func.(head) do
      [head | filter(tail, func)]
    else
      filter(tail, func)
    end
  end

  # Split could use take!
  # Works, but not for negative numbers
  def split([], _count), do: []
  def split(list, count) do
    {take(list, count), take_after_index(list, count)}
  end

  def take(list, count), do: _take(list, count, [])
  defp _take([], _count, taken), do: taken
  defp _take([head | tail], count, taken) do
    if length(taken) < count do
      _take(tail, count, taken ++ [head])
    else
      taken
    end
  end

  def take_after_index(list, count), do: _take_after_index(list, 0, count, [])
  defp _take_after_index([], _index, _count_from_on, result), do: result
  defp _take_after_index([head | tail], index, count_from_on, result) do
    if index >= count_from_on do
      _take_after_index(tail, index + 1, count_from_on, result ++ [head])
    else
      _take_after_index(tail, index + 1, count_from_on, result)
    end
  end

  # Exercise: ListsAndRecursion-6
  # MyList.flatten([1, [2, 3, [4]], 5, [[[6]]]])
  def flatten(list), do: _flatten(list, [])
  defp _flatten([], res), do: res
  defp _flatten([head | tail], res) do
    if is_list(head) do
      _flatten(tail, _flatten(head, res)) # better?
    else
      # IO.puts "#{head} is not a list, it's tail is:"
      # IO.inspect tail
      _flatten(tail, res ++ [head])
    end
  end

  # Exercise: ListsAndRecursion-7
  # Write comprehension for prime numbers from 2 to n. Use MyList.span 2, n

  # Answer:
  # for primes <- MyList.span(2, 10), !Enum.member?(Enum.uniq(for x <- MyList.span(2, 10), y <- MyList.span(2, 10), rem(x, y) == 0  && x > y, do: x), primes), do: primes
end
