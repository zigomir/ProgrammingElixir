defmodule Issues.GithubIssues do
  require Logger

  @user_agent [{"User-agent", "Elixir zigomir@gmail.com"}]
  @github_url Application.get_env(:issues, :github_url)

  # To test this run `iex -S mix`
  # Issues.GithubIssues.fetch("elixir-lang", "elixir")
  def fetch(user, project) do
    Logger.info "Fetching user #{user}'s project #{project}"
    issues_url(user, project)
    |> HTTPoison.get!(@user_agent) # find out why .get (without !) won't work
    |> handle_response
  end

  def issues_url(user, project) do
    "#{@github_url}/repos/#{user}/#{project}/issues"
  end

  def handle_response(%HTTPoison.Response{status_code: 200, body: body}) do
    Logger.info "Successful response"
    Logger.debug fn -> inspect(body) end
    {:ok, :jsx.decode(body)}
  end
  def handle_response(%HTTPoison.Response{status_code: status, body: body}) do
    Logger.error "Error #{status} returned"
    {:error, :jsx.decode(body)}
  end
end
