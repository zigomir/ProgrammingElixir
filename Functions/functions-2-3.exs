fb_sub = fn
  (0, 0, _) -> "FizzBuzz"
  (0, _, _) -> "Fizz"
  (_, 0, _) -> "Buzz"
  (_, _, third) -> third
end

# IO.puts fb_sub.(0, 0, 100)
# IO.puts fb_sub.(0, 1, 100)
# IO.puts fb_sub.(1, 0, 100)

# rem(a, b)
fizz_buzz = fn (n) ->
  fb_sub.(rem(n, 3), rem(n, 5), n)
end

IO.puts fizz_buzz.(10)
IO.puts fizz_buzz.(11)
IO.puts fizz_buzz.(12)
IO.puts fizz_buzz.(13)
IO.puts fizz_buzz.(14)
IO.puts fizz_buzz.(15)
IO.puts fizz_buzz.(16)
