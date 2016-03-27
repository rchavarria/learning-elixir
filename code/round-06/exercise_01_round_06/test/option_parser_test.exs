defmodule OptionParserTest do

  use ExUnit.Case

  test "parses a --help option" do
    { parsed, _, _ } = OptionParser.parse([ "--help" ], [])
    assert [ help: true ] == parsed
  end

  test "parses a -h flag as --help because of a switch: parameter" do
    { parsed, _, _ } = OptionParser.parse(
      [ "-h" ],
      strict: [ help: :boolean],
      aliases: [ h: :help ]
      )
    assert [ help: true ] == parsed
  end

  test "knows how to parse only the --help option" do
    { parsed, _, errors } = OptionParser.parse(
      [ "--help", "--config" ],
      strict: [ help: :boolean]
      )

    assert [ help: true ] == parsed
    assert [{ "--config", nil }] == errors
  end

  test "parses the rest of the argumets" do
    { _, remaining, _ } = OptionParser.parse(
      [ "--help", "one", "two" ],
      strict: [ help: :boolean ]
      )

    assert [ "one", "two" ] == remaining
  end

end
