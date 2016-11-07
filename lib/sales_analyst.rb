require_relative './calculator'

class SalesAnalyst
  include Calculator
  attr_reader :sales_engine

  WEEKDAYS = [
    "Sunday",
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday",
    "Saturday"
  ]

  def initialize(sales_engine)
    @sales_engine = sales_engine
  end

  def average_items_per_merchant
    result = total_number_of_items / total_number_of_merchants.to_f
    result.round(2)
  end

  def average_invoices_per_merchant
    result = total_number_of_invoices / total_number_of_merchants.to_f
    result.round(2)
  end

  def average_unit_price_per_item
    result = total_price_for_all_items / total_number_of_items.to_f
    result.round(2)
  end

  def invoices_per_day_of_week
    invoices_sorted_by_day_of_week.map do |key, value|
      value.length
    end
  end

  def invoice_count_by_day_of_week
    result = {}
    invoices_sorted_by_day_of_week.each do |key, value|
      result[WEEKDAYS[key]] = value.length
    end
    result
  end

  def invoices_sorted_by_day_of_week
    all_invoices.group_by do |invoice|
      invoice.created_at.wday
    end
  end

  def average_invoices_per_day
    result = total_number_of_invoices / WEEKDAYS.length.to_f
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

  def average_invoices_per_merchant_standard_deviation
    calculate_standard_deviation(
      invoices_per_merchant,
      average_invoices_per_merchant,
      total_number_of_merchants)
    .round(2)
  end

  def average_invoices_per_day_standard_deviation
    calculate_standard_deviation(
      invoices_per_day_of_week,
      average_invoices_per_day,
      WEEKDAYS.length)
    .round(2)
  end

  def merchants_with_high_item_count
    plus_one_standard_deviation = item_standard_deviations(1)
    all_merchants.find_all do |merchant|
      merchant.items.count >= plus_one_standard_deviation
    end
  end

  def item_standard_deviations(num)
    average_items_per_merchant + \
      num * average_items_per_merchant_standard_deviation
  end

  def price_standard_deviations(num)
    average_unit_price_per_item + \
      num * average_unit_price_per_item_standard_deviation
  end

  def invoices_per_day_standard_deviation(num)
    average_invoices_per_day + \
      num * average_invoices_per_day_standard_deviation
  end

  def invoices_per_merchant_standard_deviation(num)
    average_invoices_per_merchant + \
      num * average_invoices_per_merchant_standard_deviation
  end

  def average_item_price_for_merchant(merchant_id)
    merchant = sales_engine.merchants.find_by_id(merchant_id)
    number_of_items = merchant.items.count
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
    plus_two = price_standard_deviations(2)
    all_items.find_all do |item|
      item.unit_price >= plus_two
    end
  end

  def top_merchants_by_invoice_count
    plus_two = invoices_per_merchant_standard_deviation(2)
    all_merchants.find_all do |merchant|
      merchant.invoices.count > plus_two
    end
  end

  def bottom_merchants_by_invoice_count
    minus_two = invoices_per_merchant_standard_deviation(-2)
    all_merchants.find_all do |merchant|
      merchant.invoices.count < minus_two
    end
  end

  def top_days_by_invoice_count
    plus_one = invoices_per_day_standard_deviation(1)
    invoice_count_by_day_of_week.keep_if do |key, value|
      value > plus_one
    end.keys
  end

  def invoice_status(status)
    result = (invoices_with_status(status) / total_number_of_invoices.to_f)
    (result * 100).round(2)
  end

  def invoices_with_status(status)
    all_invoices.find_all do |invoice|
      invoice.status == status
    end.count
  end

  def items_per_merchant
    all_merchants.map do |merchant|
      merchant.items.count
    end
  end

  def invoices_per_merchant
    all_merchants.map do |merchant|
      merchant.invoices.count
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
