defmodule Issues.GitHubIssues do

  def fetch(user, project) do
    "https://api.github.com/repos/#{user}/#{project}/issues"
    |> HTTPoison.get
    |> handle_response
    |> IO.inspect
  end

  defp handle_response({:ok, %{status_code: 200, body: body} }), do: {:ok, body}
  defp handle_response({:ok, %{status_code: ___, body: body} }), do: {:error, body}
  defp handle_response({:error, error }), do: {:error, error}

end
