defmodule RegexTest do

  use ExUnit.Case

  test "matches the final part of a string" do
    xml = "xml version"
    captures = Regex.named_captures(~r/xml (?<version>.*)/, xml)
    assert captures["version"] == "version"
  end

  test "matches the initial part of a string" do
    xml = "xml version"
    captures = Regex.named_captures(~r/(?<matched_xml>[^\s]*) version/, xml)
    assert captures["matched_xml"] == "xml"
  end

  test "matches the middle part of a string" do
    xml = "<xml>some xml value</xml>"
    captures = Regex.named_captures(~r{<xml>(?<value>.*)</xml>}, xml)
    assert captures["value"] == "some xml value"
  end

  test "matches a very complex value" do
    xml = "some before<tag>this value</tag>some after"
    captures = Regex.named_captures(~r/.*<tag>(?<value>.*)<\/tag>.*/, xml)
    assert captures["value"] == "this value"
  end

end
