defmodule Issues.TableFormatter do

  def print_table(issues) do
    issue_with_longest_id    = Enum.max_by(issues, fn(issue) -> String.length(Integer.to_string(issue["id"])) end)
    issue_with_longest_title = Enum.max_by(issues, fn(issue) -> String.length(issue["title"]) end)
    longest_id               = String.length Integer.to_string issue_with_longest_id["id"]
    longest_title            = String.length issue_with_longest_title["title"]

    render_header(longest_id, longest_title)
    render_rows(issues)
  end

  defp render_header(longest_id, longest_title) do
    hash_spaces       = String.duplicate(" ", longest_id)
    id_spaces         = String.duplicate("-", longest_id + 1) # one before and one after
    created_at_spaces = String.duplicate("-", 22)
    title_spaces      = String.duplicate("-", longest_title + 1) # one before

    header            = "##{hash_spaces}| created_at           | title"
    header_line       = "#{id_spaces}+#{created_at_spaces}+#{title_spaces}"

    IO.puts header
    IO.puts header_line
  end

  # Issues.CLI.run ["elixir-lang", "elixir"]
  defp render_rows([]), do: :ok
  defp render_rows([ issue | rest ]) do
    IO.puts "#{issue["id"]} | #{issue["created_at"]} | #{issue["title"]}"
    render_rows(rest)
  end

end
