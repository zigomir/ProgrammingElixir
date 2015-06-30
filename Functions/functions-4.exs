prefix = fn (first_string) ->
  fn (second_string) ->
    "#{first_string} #{second_string}"
  end
end

ziga = prefix.("Ziga")
IO.puts ziga.("Vidic")
