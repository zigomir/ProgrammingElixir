# Exercise: ControlFlow-1
defmodule FizzBuzz do

  def run(n) do
    fizzbuzz(1, n)
  end

  defp fizzbuzz(current_step, last_step) when current_step > last_step, do: :end
  defp fizzbuzz(current_step, last_step) do
     case current_step do
       current_step when rem(current_step, 3) == 0 and rem(current_step, 5) == 0 -> IO.puts "FizzBuzz"
       current_step when rem(current_step, 3) == 0                               -> IO.puts "Fizz"
       current_step when rem(current_step, 5) == 0                               -> IO.puts "Buzz"
       _                                                                         -> IO.puts current_step
     end
    fizzbuzz(current_step + 1, last_step)
  end

  # file = FizzBuzz.ok! File.open("some_file.txt")
  def ok!(data) do
    case data do
      {:ok, data} -> data
      _ -> raise data
    end
  end
end

# Exercise: ControlFlow-2
# I think the best version of fizz buzz is the one implemented with guard clauses on pages 126-127.
# It's easy to read with when guard clauses. I also like the fact that we apply private fizzbuzz functions
# through Enum.map. I can not say which will be easiest to maintain. Depends on the knowledge of the
# developer. But any Elixir developer should easily read and change any of these.
# On the second question I can answer with "yes". Guard clauses will defenitly come as my first thing
# on my mind developing Elixir programs.
