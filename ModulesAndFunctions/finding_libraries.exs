# Convert a float to a string with two decimal digits. (Erlang)
:io.format("~.2f~n", [20.1234]) # where ~n is for newline

# Get the value of an operating-system environment variable. (Elixir)
IO.puts System.get_env("USER")

# Return the extension component of a file name (so return .exs if given "dave/test.exs") (Elixir)
IO.puts Path.extname("dave/test.exs")

# Return the process's current working directory. (Elixir)
IO.puts System.cwd()

# Convert a string containing JSON into Elixir data structures. (Just find; don't install)
# Answer: https://github.com/devinus/poison

# Execute a command in your operating system's shell.
IO.inspect System.cmd("whoami", [])
