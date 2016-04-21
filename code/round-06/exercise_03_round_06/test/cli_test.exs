defmodule Issues.CLITest do

  use ExUnit.Case

  doctest Issues.CLI

  test "parses :help if no argument is given" do
    assert Issues.CLI.parse_args([ "" ]) == :help
  end

  test "parses :help if --help argument is given" do
    assert Issues.CLI.parse_args([ "--help" ]) == :help
  end

  test "parses :help if -h flag is given" do
    assert Issues.CLI.parse_args([ "-h" ]) == :help
  end

  test "does not understand one single argument" do
    assert Issues.CLI.parse_args([ "just one" ]) == :help
    assert Issues.CLI.parse_args([ "-h", "just one" ]) == :help
  end

  test "parses three arguments" do
    args = Issues.CLI.parse_args([ "user", "project", "34" ])
    assert { "user", "project", 34 } == args
  end

  test "fills the third argument if only two given" do
    args = Issues.CLI.parse_args([ "user", "project" ])
    assert { "user", "project", 5 } == args
  end

  test "sort ascending orders is ok" do
    fake_issues = for i <- ["a", "c", "b"], do: [{"created_at", i}, {"other", "foo"}]
    converted = Issues.CLI.convert_to_list_of_hashdicts(fake_issues)
    ordered = Issues.CLI.sort_into_ascending_order(converted);
    dates_extracted = for i <- ordered, do: i["created_at"]
    assert ["a", "b", "c"] == dates_extracted
  end

end
