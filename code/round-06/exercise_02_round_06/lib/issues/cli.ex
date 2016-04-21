defmodule Issues.CLI do

  @default_n_issues 5
  @parse_options [
    strict: [ help: :boolean ],
    aliases: [ h: :help ]
  ]

  @doc """
  Can invoke the applications with:
    mix run -e 'Issues.CLI.run(["rchavarria", "english-by-einar"])'
    mix run -e 'Issues.CLI.run(["--help"])'
  """
  def run(argv) do
    argv
    |> parse_args
    |> process
  end

  defp parse_args(argv) do
    parsed = OptionParser.parse(argv, @parse_options)

    case parsed do
      { [ help: true ], _, _ } -> :help
      { _, [ user, project, count ], _ } -> { user, project, String.to_integer(count) }
      { _, [ user, project ], _ } -> { user, project, @default_n_issues }
      _ -> :help
    end
  end

  defp process(:help) do
    IO.puts """
    Usage: issues <user> <project> [ count | #{@default_n_issues} ]
    """

    System.halt(0)
  end
  defp process({ user, project, count }) do
    Issues.GitHubIssues.fetch(user, project)
    |> decode_response
    |> convert_to_list_of_hashdicts
    |> IO.inspect
  end

  defp decode_response({ :ok, body }), do: body
  defp decode_response({ :error, error_body }) do
    {_, message} = List.keyfind(error_body, "message", 0)
    IO.puts """
    GitHub replied with an error: #{message}
    """

    System.halt(2)
  end

  defp convert_to_list_of_hashdicts(list) do
    list
    |> Enum.map(&Enum.into(&1, HashDict.new))
  end

end
