defmodule GildedRose.StringUtility do
  def trim_downcase_string(string) do
    string
    |> String.trim()
    |> String.replace(~r/\s+/, " ")
    |> String.downcase()
  end
end
