list_contact = fn (list_a, list_b) ->
  list_a ++ list_b
end

res = list_contact.([:a, :b], [:c, :d])
IO.puts inspect res


sum = fn (a, b, c) -> a + b + c end

IO.puts sum.(1, 2, 3)


pair_tuple_to_list = fn ({a, b}) -> [a, b] end

ptl = pair_tuple_to_list.({ 1234, 5678 })
IO.puts inspect ptl
