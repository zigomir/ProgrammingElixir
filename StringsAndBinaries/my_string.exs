defmodule MyString do

  # Exercise: StringsAndBinaries-1
  def printable(charlist) do
    String.printable? IO.chardata_to_string(charlist)
  end

  # Exercise: StringsAndBinaries-2
  def anagram(word1, word2) do
    # word 1 contains all caracters of word 2
    list_of_chars1 = String.codepoints(word1)
    list_of_chars2 = String.codepoints(word2)

    # for a <- list_of_chars1, b <- list_of_chars2,
    # Enum.all?([2, 4, 6], fn(x) -> rem(x, 2) == 0 end)
    Enum.all?(list_of_chars2, fn(x) -> Enum.member?(list_of_chars1, x) end)
  end

  # Exercise: StringsAndBinaries-3
  # Try the following lines in iex:
  # iex> ['cat' | 'dog']
  # ['cat', 100, 111, 103]
  # Why does iex print 'cat' as a string, but 'dog' as individual numbers?
  # Because we're doing pattern matching and tail of list is treated as list, thus
  # 'dog' is treated as char list.

  # Exercise: StringsAndBinaries-4
  # (Hard): Write a function that takes a single-quoted string of the form
  # number [+-*/] and returns the result of the calculation. The individual
  # numbers do not have leading plus or minus signs.
  #
  # calculate('123 + 27') => 150
  def calculate(expression) do
    operands           = String.split(IO.chardata_to_string(expression), " ")
    operand1           = String.to_integer Enum.at(operands, 0)
    calculation_symbol = Enum.at(operands, 1)
    operand2           = String.to_integer Enum.at(operands, 2)

    _calculate(calculation_symbol, operand1, operand2)
  end

  defp _calculate("+", operand1, operand2) do
    operand1 + operand2
  end
  defp _calculate("-", operand1, operand2) do
    operand1 - operand2
  end
  defp _calculate("*", operand1, operand2) do
    operand1 * operand2
  end
  defp _calculate("/", operand1, operand2) do
    operand1 / operand2
  end

  # Exercise: StringsAndBinaries-5
  # MyString.center(["cat", "zebra", "elephant"])
  def center(list) do
    max_length = String.length Enum.max_by(list, fn(x) -> String.length(x) end)
    _center(list, max_length)
  end
  defp _center([], _max_length), do: nil
  defp _center([word | tail], max_length) do
    to_pad = div(max_length - String.length(word), 2)
    IO.puts String.rjust(word, String.length(word) + to_pad)
    _center(tail, max_length)
  end

  # Exercise: StringsAndBinaries-6
  # iex> MyString.capitalize_sentences("oh. a DOG. woof. ")
  # "Oh. A dog. Woof. "
  def capitalize_sentences(sentence) do
    sentence
    |> String.downcase
    |> String.split(". ")
    |> Enum.map(&(String.capitalize(&1)))
    |> Enum.join(". ")
  end

end
