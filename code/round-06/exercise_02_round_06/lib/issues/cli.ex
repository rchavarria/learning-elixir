defmodule Issues.CLI do

  @default_n_issues 5
  @parse_options [
    strict: [ help: :boolean ],
    aliases: [ h: :help ]
  ]

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
    Issues.GithubIssues.fetch(user, project)
  end

end
