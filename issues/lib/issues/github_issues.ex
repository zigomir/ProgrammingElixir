defmodule Issues.GithubIssues do
  @user_agent [{"User-agent", "Elixir zigomir@gmail.com"}]
  @github_url Application.get_env(:issues, :github_url)

  # To test this run `iex -S mix`
  # Issues.GithubIssues.fetch("elixir-lang", "elixir")
  def fetch(user, project) do
    issues_url(user, project)
    |> HTTPoison.get!(@user_agent) # find out why .get (without !) won't work
    |> handle_response
  end

  def issues_url(user, project) do
    "#{@github_url}/repos/#{user}/#{project}/issues"
  end

  def handle_response(%HTTPoison.Response{status_code: 200, body: body}) do
    {:ok, :jsx.decode(body)}
  end
  def handle_response(%HTTPoison.Response{status_code: ___, body: body}) do
    {:error, :jsx.decode(body)}
  end
end
