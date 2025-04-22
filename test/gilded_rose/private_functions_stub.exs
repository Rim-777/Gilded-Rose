defmodule GildedRose.PrivateFunctionsStub do
  @moduledoc """
  Stub module is aimed only for testing private functions of the GildedRose .

  Can not ne in use in the applications
  """

  import GildedRose.ItemTypes

  @max_quality 50

  def update_decreasable_item(item) do
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

  def update_increasable_item(item) do
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

  def update_eventable_item(item) do
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

  def decrease_sell_in(item) do
    case unsaleable_type?(item) do
      true ->
        item

      false ->
        %{item | sell_in: item.sell_in - 1}
    end
  end

  def update_conjured_item(item) do
    case conjured_type?(item) do
      true ->
        decrease_quality(item, 2)

      false ->
        item
    end
  end

  def increment_quality(item) do
    case item.quality < @max_quality do
      true ->
        %{item | quality: item.quality + 1}

      false ->
        item
    end
  end

  def decrease_quality(item, delta \\ 1) do
    %{item | quality: item.quality - delta}
  end
end
