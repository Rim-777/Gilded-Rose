Code.require_file("private_functions_stub.exs", __DIR__)

defmodule GildedRose.StubTest do
  use ExUnit.Case

  import GildedRose.PrivateFunctionsStub

  test "increment_quality/1 increases item quality value" do
    assert %Item{quality: 49} = increment_quality(%Item{quality: 48})
    assert %Item{quality: 50} = increment_quality(%Item{quality: 50})
  end

  test "decrease_quality/1 decreases item quality value" do
    item = %Item{quality: 50}
    assert decrease_quality(item) == %Item{quality: 49}
    assert decrease_quality(item, 2) == %Item{quality: 48}
  end

  test "update_conjured_item/1 decrease quality of items with conjured type" do
    item = %Item{name: "Conjured Mana Cake", quality: 6}

    expected_result = %Item{name: "Conjured Mana Cake", quality: 4}
    assert update_conjured_item(item) == expected_result

    item = %Item{name: "Mana Cake", quality: 6}
    assert update_conjured_item(item) == item
  end

  test "decrease_sell_in/1 decrease sell it for any items except items with Sulfuras type" do
    item = %Item{name: "Conjured Mana Cake", sell_in: 6}

    expected_result = %Item{name: "Conjured Mana Cake", sell_in: 5}
    assert decrease_sell_in(item) == expected_result

    item = %Item{name: "Sulfuras, Hand of Ragnaros", sell_in: 0, quality: 80}
    assert decrease_sell_in(item) == item
  end

  test "update_eventable_item/1 changes quality of eventable item depends on sel_in value" do
    regular_eventable_item = %Item{name: "Backstage", sell_in: 15, quality: 20}
    assert %Item{quality: 21} = update_eventable_item(regular_eventable_item)
    regular_eventable_item = %Item{name: "Backstage", sell_in: 15, quality: 50}
    assert %Item{quality: 50} = update_eventable_item(regular_eventable_item)

    upcoming_eventable_item = %Item{name: "Backstage", sell_in: 10, quality: 30}
    assert %Item{quality: 32} = update_eventable_item(upcoming_eventable_item)
    upcoming_eventable_item = %Item{name: "Backstage", sell_in: 10, quality: 49}
    assert %Item{quality: 50} = update_eventable_item(upcoming_eventable_item)

    imminent_eventable_item = %Item{name: "Backstage", sell_in: 5, quality: 30}
    %Item{quality: 33} = update_eventable_item(imminent_eventable_item)
    imminent_eventable_item = %Item{name: "Backstage", sell_in: 5, quality: 48}
    %Item{quality: 50} = update_eventable_item(imminent_eventable_item)

    passed_eventable_item = %Item{name: "Backstage", sell_in: -1, quality: 49}
    %Item{quality: 0} = update_eventable_item(passed_eventable_item)
  end

  test "update_increasable_item/1 increase quality value for increasable item types" do
    assert %Item{quality: 1} = update_increasable_item(%Item{name: "Aged Brie", sell_in: 0, quality: 0})
    assert %Item{quality: 2} = update_increasable_item(%Item{name: "Aged Brie", sell_in: -1, quality: 0})

    non_increasable_item = %Item{name: "Some Item", sell_in: 5, quality: 30}
    assert update_increasable_item(non_increasable_item) == non_increasable_item
  end

  test "update_decreasable_item/1 increase quality value for decreasable item types" do
    assert %Item{quality: 0} = update_decreasable_item(%Item{name: "Just an item", sell_in: 3, quality: 1})
    assert %Item{quality: 0} = update_decreasable_item(%Item{name: "Just an item", sell_in: 3, quality: 0})
    assert %Item{quality: 3} = update_decreasable_item(%Item{name: "Just an item", sell_in: -1, quality: 5})

    non_decreasable_item = %Item{name: "Backstage", sell_in: 5, quality: 30}
    assert update_decreasable_item(non_decreasable_item) == non_decreasable_item
  end
end
