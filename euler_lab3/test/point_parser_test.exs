defmodule MyLab3.PointParserTest do
  use ExUnit.Case, async: true

  alias MyLab3.PointParser

  test "parses space separated values" do
    assert {:ok, {1.0, 2.5}} == PointParser.parse("1 2.5")
  end

  test "parses semicolon and tab separated values" do
    assert {:ok, {3.0, -1.0}} == PointParser.parse("3;-1")
    assert {:ok, {3.0, -1.0}} == PointParser.parse("3\t-1")
  end

  test "skips bad input" do
    assert :skip == PointParser.parse("")
    assert :skip == PointParser.parse("a b")
    assert :skip == PointParser.parse("1 2 3")
  end
end
