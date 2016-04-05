defmodule Issues.CLI do

  @default_count 4

  @moduledoc """
  Handle the command line parsing and the dispatch to
  the various functions that end up generating a
  table of the last _n_ issues in a github project
  """
  def run(argv) do
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
    case  parse  do
    { [ help: true ], _, _ } -> :help
    { _, [ user, project, count ], _ } -> { user, project, String.to_integer(count) }
    {  _, [ user, project ], _ } -> { user, project, @default_count }
    
    _ -> :help
    end
  end

  def process(:help) do
    IO.puts """
    usage: rct_issues <user> <project> [ count | #{@default_count} ]
    """
    System.halt(0)
  end
  def process({ user, project, _count }) do
    RctIssues.GithubIssues.fetch(user, project)
    |> decode_response
  end

  def decode_reponse({:ok, body}), do: body
  def decode_reponse({:error, errro}) do
    {_, message} = List.keyfind(error, "message", 0)
    IO.puts "Error fetching from GitHub: #{message}"
    System.halt(2)
  end

  @doc """
  (extract from the book)
  The JSON that GitHub returns for a successful response is a list with one
  element per GitHub issue. That element is itself a list of key/value tuples.
  To make these easier (and more efficient) to work with, we’ll convert our
  list of lists into a list of Elixir hashdicts, which give you fast access by
  key to a list of key/value pairs
  """
  def convert_to_list_of_hashdicts(list) do
    list
    |> Enum.map(&Enum.into(&1, HashDict.new))
  end

end

