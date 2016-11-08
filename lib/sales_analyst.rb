require_relative './calculator'
require_relative './sales_analyst_helper'

class SalesAnalyst
  include Calculator
  include SalesAnalystHelper
  attr_reader :sales_engine

  def initialize(sales_engine)
    @sales_engine = sales_engine
    @weekdays = [
      "Sunday",
      "Monday",
      "Tuesday",
      "Wednesday",
      "Thursday",
      "Friday",
      "Saturday"
    ]
  end

  def merchants_with_high_item_count
    plus_one_standard_deviation = items_per_merchant_standard_deviations(1)
    all_merchants.find_all do |merchant|
      merchant.items.count >= plus_one_standard_deviation
    end
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
    plus_two = price_per_item_standard_deviations(2)
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

  def total_revenue_by_date(date)
    invoices = sales_engine.find_all_invoices_by_date(date)
    sum_of_successful_charges_for_invoices(invoices)
  end

  def revenue_by_merchant(merchant_id)
    invoices = sales_engine.find_invoices_by_merchant_id(merchant_id)
    sum_of_successful_charges_for_invoices(invoices)
  end

  def top_revenue_earners(number_of_merchants = 20)
    merchants_ranked_by_revenue
    .take(number_of_merchants)
  end

  def merchants_with_pending_invoices
    # TODO; mock out .has_pending_invoice? test
    all_merchants.find_all do |merchant|
      merchant.has_pending_invoice?
    end
  end

  def merchants_with_only_one_item
    all_merchants.find_all do |merchant|
      merchant.items.count == 1
    end
  end

  def merchants_with_only_one_item_registered_in_month(month)
    merchants = all_merchants.find_all do |merchant|
      merchant.created_at_month == month
    end
    merchants & merchants_with_only_one_item
  end

  def most_sold_item_for_merchant(merchant_id)
    #TODO refactor!!
    merchant = sales_engine.find_merchant_by_id(merchant_id)

    paid_invoice_ids = paid_invoice_ids_by_merchant(merchant)

    invoice_items = sales_engine.collect_invoice_items(paid_invoice_ids).flatten

    items = invoice_items.group_by do |invoice_item|
      invoice_item.item_id
    end

    results = items.map do |item_id, items|
      [items.map(&:quantity).map(&:to_i).reduce(:+), item_id]
    end.sort.reverse

    items_with_counts = results.chunk_while do |i, j|
      i.first == j.first
    end.first

    item_ids = items_with_counts.map do |array|
      array.last
    end

    sales_engine.collect_items(item_ids)
  end

  def best_item_for_merchant(merchant_id)
    merchant = sales_engine.find_merchant_by_id(merchant_id)
    paid_invoice_ids = paid_invoice_ids_by_merchant(merchant)
    invoice_items = sales_engine.collect_invoice_items(paid_invoice_ids).flatten
    items = invoice_items.group_by do |invoice_item|
      invoice_item.item_id
    end


    the_end = items.map do |item_id, items|
      [ (items.map(&:quantity).map(&:to_f) * items.first.unit_price ).reduce(:+), item_id]
    end.sort.reverse.first.last
    # binding.pry


    
    item = sales_engine.items.find_by_id(the_end)
    return item
  end
end
