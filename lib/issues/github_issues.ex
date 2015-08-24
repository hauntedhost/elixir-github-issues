defmodule Issues.GithubIssues do
  @github_url Application.get_env(:issues, :github_url)
  @user_agent [{"User-agent", "Sean Omlor somlor@eml.cc"}]

  def fetch(user, project) do
    issues_url(user, project)
      |> HTTPoison.get(@user_agent)
      |> handle_response
  end

  def issues_url(user, project) do
    "#{@github_url}/repos/#{user}/#{project}/issues"
  end

  def handle_response(%{status_code: 200, body: body}) do
    {:ok, JSON.decode(body)}
  end

  def handle_response(%{status_code: _, body: body}) do
    {:error, JSON.decode(body)}
  end
end