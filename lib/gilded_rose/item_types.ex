defmodule GildedRose.ItemTypes do
  @moduledoc """
  Provides functions for handling different item types in the Gilded Rose system.
  Defines item types and offers functions to check their characteristics, such as whether they are unsellable,
  can increase or decrease in quality, and other specific features.
  """

  alias GildedRose.StringUtility

  @available_types %{
    aged_brie: :aged_brie,
    backstage: :backstage,
    sulfuras: :ulfuras,
    conjured: :conjured,
    regular: :regular
  }

  @decreasable_types [@available_types.regular]
  @increasable_items [@available_types.aged_brie]
  @unsaleable_items [@available_types.sulfuras]
  @eventable_items [@available_types.backstage]
  @conjured_items [@available_types.conjured]

  @max_quality 50
  @min_quality 0

  @doc """
  Checks if an item is unsellable.

  ## Examples

      iex> item = %Item{name: "Sulfuras, Hand of Ragnaros", sell_in: 0, quality: 80}
      iex> GildedRose.ItemTypes.unsaleable_type?(item)
      true
  """
  def unsaleable_type?(item) do
    item_type(item) in @unsaleable_items
  end

  @doc """
  Checks if an item is conjured.

  ## Examples

      iex> item = %Item{name: "Conjured Mana Cake", sell_in: 3, quality: 6}
      iex> GildedRose.ItemTypes.conjured_type?(item)
      true
  """
  def conjured_type?(item) do
    item_type(item) in @conjured_items
  end

  @doc """
  Checks if an item's quality can decrease.

  ## Examples

      iex> item = %Item{name: "Elixir of the Mongoose", sell_in: 5, quality: 5}
      iex> GildedRose.ItemTypes.decreasable_type?(item)
      true
  """
  def decreasable_type?(item) do
    item_type(item) in @decreasable_types and item.quality > @min_quality
  end

  @doc """
  Checks if an item's quality can increase.

  ## Examples

      iex> item = %Item{name: "Aged Brie", sell_in: 2, quality: 49}
      iex> GildedRose.ItemTypes.increasable_type?(item)
      true
  """
  def increasable_type?(item) do
    item_type(item) in @increasable_items and item.quality < @max_quality
  end

  @doc """
  Checks if an item is eventable.

  ## Examples

      iex> item = %Item{name: "Backstage passes to a TAFKAL80ETC concert", sell_in: 15, quality: 20}
      iex> GildedRose.ItemTypes.eventable_type?(item)
      true
  """
  def eventable_type?(item) do
    item_type(item) in @eventable_items
  end

  defp item_type(%Item{name: name}) do
    normalized_name = StringUtility.trim_downcase_string(name)

    cond do
      String.contains?(normalized_name, "aged brie") ->
        @available_types.aged_brie

      String.contains?(normalized_name, "backstage") ->
        @available_types.backstage

      String.contains?(normalized_name, "sulfuras") ->
        @available_types.sulfuras

      String.contains?(normalized_name, "conjured") ->
        @available_types.conjured

      true ->
        @available_types.regular
    end
  end
end
