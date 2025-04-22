defmodule GildedRose.StringUtilityTest do
  use ExUnit.Case

  alias GildedRose.StringUtility

  test "trim_downcase_string/1 lowercase removes extra spaces" do
    assert StringUtility.trim_downcase_string("  Hello   Gilded   Rose  ") == "hello gilded rose"
    assert StringUtility.trim_downcase_string("Elixir  is   FUN") == "elixir is fun"
    assert StringUtility.trim_downcase_string("  Multiple    spaces   ") == "multiple spaces"
    assert StringUtility.trim_downcase_string("AlreadyTrimmed") == "alreadytrimmed"
    assert StringUtility.trim_downcase_string("") == ""
  end
end
