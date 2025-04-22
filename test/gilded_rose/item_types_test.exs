defmodule GildedRose.ItemTypesTest do
  use ExUnit.Case
  alias GildedRose.ItemTypes

  describe "unsaleable_type?/1" do
    test "returns true for sulfuras" do
      item = %Item{name: "Sulfuras, Hand of Ragnaros", quality: 80}
      assert ItemTypes.unsaleable_type?(item) == true
    end
  end

  describe "conjured_type?/1" do
    test "returns true for conjured items" do
      item = %Item{name: "Conjured Mana Cake", quality: 6}
      assert ItemTypes.conjured_type?(item) == true
    end
  end

  describe "decreasable_type?/1" do
    test "returns true for regular items with quality above min" do
      item = %Item{name: "Elixir of the Mongoose", quality: 5}
      assert ItemTypes.decreasable_type?(item) == true
    end

    test "returns false for regular items with quality at min" do
      item = %Item{name: "Elixir of the Mongoose", quality: 0}
      assert ItemTypes.decreasable_type?(item) == false
    end
  end

  describe "increasable_type?/1" do
    test "returns true for aged brie with quality below max" do
      item = %Item{name: "Aged Brie", quality: 49}
      assert ItemTypes.increasable_type?(item) == true
    end

    test "returns false for aged brie with quality at max" do
      item = %Item{name: "Aged Brie", quality: 50}
      assert ItemTypes.increasable_type?(item) == false
    end
  end

  describe "eventable_type?/1" do
    test "returns true for backstage passes" do
      item = %Item{name: "Backstage passes to a TAFKAL80ETC concert", quality: 20}
      assert ItemTypes.eventable_type?(item) == true
    end
  end
end
