require IEx
defmodule Issues.CLI do

  @default_count 4

  @moduledoc """
  Handle the command line parsing and the dispatch to
  various functions that end up generating a
  table of the last _n_ issues in a github project
  """

  def main(argv) do
    argv
      |> parse_args
      |> process
  end

  @doc """
  `argv` can be -h or --help, which returns :help.

  Otherwise it is a github user name, project name, and (optionally)
  the number of entries to format.

  Return a tuple of `{ user, project, count }`, or `:help` if help was given.
  """
  def parse_args(argv) do
    parse = OptionParser.parse(argv, switches: [ help: :boolean ],
                                     aliases:  [ h:    :help    ])
    case parse do
      {[help: true], _, _}           -> :help
      {_, [user, project, count], _} -> {user, project, String.to_integer count}
      {_, [user, project], _}        -> {user, project, @default_count}
      _                              ->  :help
    end
  end

  def process(:help) do
    IO.puts """
    usage: issues <user> <project> [ count | #{@default_count} ]
    """
    System.halt(0)
  end

  def process({user, project, count}) do
    Issues.GithubIssues.fetch(user, project)
    |> decode_response
    |> convert_list_of_hashdicts
    |> sort_into_ascending_order
    |> Enum.take(count)
    |> format_table
  end

  def decode_response({:ok, body}), do: body
  def decode_response({:error, error}) do
    {_, message} = List.keyfind(error, "message", 0)
    IO.puts "Error fetching from Github: #{message}"
    System.halt(2)
  end

  def convert_list_of_hashdicts(list) do
    list
    |> Enum.map(&Enum.into(&1, HashDict.new))
  end

  def sort_into_ascending_order(list_of_issues) do
    Enum.sort list_of_issues,
              fn i1, i2 -> i1["created_at"] <= i2["created_at"] end
  end

  def format_table(issues) do
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
