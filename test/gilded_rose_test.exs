defmodule GildedRoseTest do
  use ExUnit.Case

  test "update items" do
    items = [
      %Item{name: "+5 Dexterity Vest", sell_in: 10, quality: 20},
      %Item{name: "Aged Brie", sell_in: 2, quality: 0},
      %Item{name: "Elixir of the Mongoose", sell_in: 5, quality: 7},
      %Item{name: "Sulfuras, Hand of Ragnaros", sell_in: 0, quality: 80},
      %Item{name: "Sulfuras, Hand of Ragnaros", sell_in: -1, quality: 80},
      %Item{name: "Backstage passes to a TAFKAL80ETC concert", sell_in: 15, quality: 20},
      %Item{name: "Backstage passes to a TAFKAL80ETC concert", sell_in: 10, quality: 49},
      %Item{name: "Backstage passes to a TAFKAL80ETC concert", sell_in: 5, quality: 49},
      %Item{name: "Conjured Mana Cake", sell_in: 3, quality: 6}
    ]

    expected_items = [
      %Item{name: "+5 Dexterity Vest", sell_in: 7, quality: 17},
      %Item{name: "Aged Brie", sell_in: -1, quality: 4},
      %Item{name: "Elixir of the Mongoose", sell_in: 2, quality: 4},
      %Item{name: "Sulfuras, Hand of Ragnaros", sell_in: 0, quality: 80},
      %Item{name: "Sulfuras, Hand of Ragnaros", sell_in: -1, quality: 80},
      %Item{
        name: "Backstage passes to a TAFKAL80ETC concert",
        sell_in: 12,
        quality: 23
      },
      %Item{
        name: "Backstage passes to a TAFKAL80ETC concert",
        sell_in: 7,
        quality: 50
      },
      %Item{
        name: "Backstage passes to a TAFKAL80ETC concert",
        sell_in: 2,
        quality: 50
      },
      %Item{name: "Conjured Mana Cake", sell_in: 0, quality: 0}
    ]

    result_items =
      Enum.reduce(0..2, items, fn _day, items ->
        GildedRose.update_quality(items)
      end)

    assert result_items == expected_items
  end
end
