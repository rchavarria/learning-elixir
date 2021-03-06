defmodule Issues.GitHubIssues do

  require Logger

  @github_url Application.get_env(:exercise_03_round_06, :github_url)

  @doc """
  Este podría ser un comentario testeable

  ## Example
      iex> Issues.GitHubIssues.some_test
      "foo bar"
  """
  def some_test, do: "foo bar"

  def fetch(user, project) do
    Logger.info "Fetching #{user}'s project #{project}"

    "#{@github_url}/repos/#{user}/#{project}/issues"
    |> HTTPoison.get
    |> handle_response
  end

  defp handle_response({:ok, %{status_code: 200, body: body} }), do: { :ok, :jsx.decode(body) }
  defp handle_response({:ok, %{status_code: ___, body: body} }), do: { :error, :jsx.decode(body) }
  defp handle_response({:error, error }) do
    IO.puts """
    An error happened getting issues from GitHub
    """

    System.halt(2)
  end

end
