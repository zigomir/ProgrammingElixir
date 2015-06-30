# Use &... notation to rewrite the following

# Enum.map [1,2,3,4], fn x -> x + 2 end
# Enum.map [1,2,3,4], fn IO.inspect x end

# add_two = Enum.map [1,2,3,4], fn x -> x + 2 end

IO.inspect Enum.map [1,2,3,4], fn x -> x + 2 end
IO.inspect Enum.map [1,2,3,4], &(&1 + 2)

Enum.map [1,2,3,4], fn x -> IO.inspect x end
Enum.map [1,2,3,4], &(IO.inspect &1)
