defmodule Issues.CLITest do

  use ExUnit.Case

  doctest Issues.CLI

  test "parses :help if no argument is given" do
    assert Issues.CLI.run([ "" ]) == :help
  end

  test "parses :help if --help argument is given" do
    assert Issues.CLI.run([ "--help" ]) == :help
  end

  test "parses :help if -h flag is given" do
    assert Issues.CLI.run([ "-h" ]) == :help
  end

  test "does not understand one single argument" do
    assert Issues.CLI.run([ "just one" ]) == :help
    assert Issues.CLI.run([ "-h", "just one" ]) == :help
  end

  test "parses three arguments" do
    args = Issues.CLI.run([ "user", "project", "34" ])
    assert { "user", "project", 34 } == args
  end

  test "fills the third argument if only two given" do
    args = Issues.CLI.run([ "user", "project" ])
    assert { "user", "project", 5 } == args
  end

end
