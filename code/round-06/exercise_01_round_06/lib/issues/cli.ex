defmodule Issues.CLI do

  @default_n_issues 5
  @parse_options [
    strict: [ help: :boolean ],
    aliases: [ h: :help ]
  ]

  def run(argv) do
    parse_args(argv)
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

end
