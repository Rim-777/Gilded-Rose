defmodule GildedRose do
  @moduledoc """
  Provides functionality to update the quality and sell-in values of items in the Gilded Rose inventory system.

  This module handles various types of items, including regular items, aged brie, backstage passes, sulfuras,
  and conjured items. It applies specific rules to update the quality and sell-in values based on the type of item.
  """

  import GildedRose.ItemTypes

  @max_quality 50

  @doc """
  Updates the quality and sell-in values for a list of items.

  Parameters:
    - items: A list of `%Item{}` structs representing the items to be updated.
  Returns:
    - A list of `%Item{}` structs with updated quality and sell-in values.

  ## Example
    iex> GildedRose.update_quality([%Item{name: "Backstage passes to a TAFKAL80ETC concert", sell_in: 9, quality: 1}])
    [%Item{name: "Backstage passes to a TAFKAL80ETC concert", sell_in: 8, quality: 3}]
  """
  def update_quality(items) do
    Enum.map(items, &update_item/1)
  end

  defp update_item(%Item{} = item) do
    item
    |> decrease_sell_in()
    |> update_decreasable_item()
    |> update_increasable_item()
    |> update_eventable_item()
    |> update_conjured_item()
  end

  defp update_decreasable_item(item) do
    case decreasable_type?(item) do
      true ->
        decrease_with_negative_sell_in(item)

      false ->
        item
    end
  end

  defp decrease_with_negative_sell_in(item) do
    case negative_sell_in?(item) do
      true ->
        decrease_quality(item)

      false ->
        item
    end
    |> decrease_quality()
  end

  defp update_increasable_item(item) do
    case increasable_type?(item) do
      true ->
        increase_with_negative_sell_in(item)

      false ->
        item
    end
  end

  defp increase_with_negative_sell_in(item) do
    case negative_sell_in?(item) do
      true ->
        increment_quality(item)

      false ->
        item
    end
    |> increment_quality()
  end

  defp negative_sell_in?(item) do
    item.sell_in < 0
  end

  defp update_eventable_item(item) do
    case eventable_type?(item) do
      true ->
        item
        |> update_regular_eventable_item()
        |> update_upcoming_eventable_item()
        |> update_imminent_eventable_item()
        |> update_passed_eventable_item()

      false ->
        item
    end
  end

  defp update_regular_eventable_item(item) do
    increment_quality(item)
  end

  defp update_upcoming_eventable_item(item) do
    case item.sell_in < 11 do
      true ->
        increment_quality(item)

      false ->
        item
    end
  end

  defp update_imminent_eventable_item(item) do
    case item.sell_in < 6 do
      true ->
        increment_quality(item)

      false ->
        item
    end
  end

  defp update_passed_eventable_item(item) do
    case negative_sell_in?(item) do
      true ->
        %{item | quality: 0}

      false ->
        item
    end
  end

  defp decrease_sell_in(item) do
    case unsaleable_type?(item) do
      true ->
        item

      false ->
        %{item | sell_in: item.sell_in - 1}
    end
  end

  defp update_conjured_item(item) do
    case conjured_type?(item) do
      true ->
        decrease_quality(item, 2)

      false ->
        item
    end
  end

  defp increment_quality(item) do
    case item.quality < @max_quality do
      true ->
        %{item | quality: item.quality + 1}

      false ->
        item
    end
  end

  defp decrease_quality(item, delta \\ 1) do
    %{item | quality: item.quality - delta}
  end
end
