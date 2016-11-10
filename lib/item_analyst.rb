require_relative './sales_analyst'
require_relative './sales_analyst_helper'

module ItemAnalyst
  include SalesAnalystHelper

  def all_items
    sales_engine.items.all
  end

  def total_number_of_items
    all_items.count
  end

  def total_price_for_all_items
    all_items.map do |item|
      item.unit_price
    end.reduce(:+)
  end

  def unit_price_per_item
    all_items.map do |item|
      item.unit_price
    end
  end

  def average_unit_price_per_item
    result = total_price_for_all_items / total_number_of_items.to_f
    result.round(2)
  end

  def items_ordered_by_quantity_sold(items)
    items.map do |item_id, item|
      [item.map(&:quantity).map(&:to_i).reduce(:+), item_id]
    end.sort.reverse
  end

  def highest_selling_item_ids(ordered_items)
    items_with_counts = ordered_items.chunk_while do |i, j|
      i.first == j.first
    end.first
    items_with_counts.map do |array|
      array.last
    end
  end

  def highest_revenue_item_id(items)
    items.map do |item_id, item|
      [
        (item.map(&:quantity).map(&:to_f) * item.first.unit_price).reduce(:+),
        item_id
      ]
    end.sort.reverse.first.last
  end

  def golden_items
    plus_two = price_per_item_standard_deviations(2)
    all_items.find_all do |item|
      item.unit_price >= plus_two
    end
  end
end
