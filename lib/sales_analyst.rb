require_relative './calculator'

class SalesAnalyst
  include Calculator
  attr_reader :sales_engine

  def initialize(sales_engine)
    @sales_engine = sales_engine
  end

  def average_items_per_merchant
    result = total_number_of_items / total_number_of_merchants.to_f
    result.round(2)
  end

  def average_unit_price_per_item
    result = total_price_for_all_items / total_number_of_items.to_f
    result.round(2)
  end

  def total_price_for_all_items
    all_items.map do |item|
      item.unit_price
    end.reduce(:+)
  end

  def average_items_per_merchant_standard_deviation
    calculate_standard_deviation(
      items_per_merchant,
      average_items_per_merchant,
      total_number_of_merchants)
    .round(2)
  end

  def average_unit_price_per_item_standard_deviation
    calculate_standard_deviation(
      unit_price_per_item,
      average_unit_price_per_item,
      total_number_of_items)
    .round(2)
  end

  def merchants_with_high_item_count
    plus_one_standard_deviation = item_standard_deviations(1)
    all_merchants.find_all do |merchant|
      merchant.items.length >= plus_one_standard_deviation
    end
  end

  def item_standard_deviations(n)
    average_items_per_merchant + \
      n * average_items_per_merchant_standard_deviation
  end

  def price_standard_deviations(n)
    average_unit_price_per_item + \
      n * average_unit_price_per_item_standard_deviation
  end

  def average_item_price_for_merchant(id)
    merchant = sales_engine.merchants.find_by_id(id)
    number_of_items = merchant.items.length
    price_of_items = merchant.items.map(&:unit_price).reduce(:+)
    return (price_of_items / number_of_items).round(2)
  end

  def average_average_price_per_merchant
    numerator = all_merchants.map do |merchant|
      average_item_price_for_merchant(merchant.id)
    end.reduce(:+)
    return (numerator / total_number_of_merchants.to_f).round(2)
  end

  def golden_items
    plus_two_standard_deviations = price_standard_deviations(2)
    all_items.find_all do |item|
      item.unit_price >= plus_two_standard_deviations
    end
  end

  def average_invoices_per_merchant
    (total_number_of_invoices / total_number_of_merchants.to_f).round(2)
  end

  def items_per_merchant
    all_merchants.map do |merchant|
      merchant.items.length
    end
  end

  def total_number_of_items
    all_items.count
  end

  def total_number_of_merchants
    all_merchants.count
  end

  def total_number_of_invoices
    all_invoices.count
  end

  def all_items
    sales_engine.items.all
  end

  def all_merchants
    sales_engine.merchants.all
  end

  def all_invoices
    sales_engine.invoices.all
  end

  def unit_price_per_item
    all_items.map do |item|
      item.unit_price
    end
  end
end
