require_relative './calculator'
require_relative './sales_analyst_helper'
require_relative './merchant_analyst'
require_relative './item_analyst'
require_relative './invoice_analyst'

class SalesAnalyst
  include Calculator
  include SalesAnalystHelper
  include MerchantAnalyst
  include ItemAnalyst
  include InvoiceAnalyst
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

  def average_item_price_for_merchant(merchant_id)
    merchant = sales_engine.merchants.find_by_id(merchant_id)
    number_of_items = merchant.items.count
    price_of_items = merchant.items.map(&:unit_price).reduce(:+)
    return (price_of_items / number_of_items).round(2)
  end

  def average_average_price_per_merchant
    result = sum_of_average_prices_for_all_merchants / \
    total_number_of_merchants.to_f
    return result.round(2)
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
    merchants_created_in_month(month) & merchants_with_only_one_item
  end

  def paid_items_by_merchant(merchant_id)
    merchant = sales_engine.find_merchant_by_id(merchant_id)
    paid_invoice_ids = paid_invoice_ids_by_merchant(merchant)
    invoice_items = sales_engine
    .collect_invoice_items(paid_invoice_ids)
    .flatten
    invoice_items.group_by do |invoice_item|
      invoice_item.item_id
    end
  end

  def most_sold_item_for_merchant(merchant_id)
    items = paid_items_by_merchant(merchant_id)
    ordered_items = items_ordered_by_quantity_sold(items)
    item_ids = highest_selling_item_ids(ordered_items)
    sales_engine.collect_items(item_ids)
  end

  def best_item_for_merchant(merchant_id)
    items = paid_items_by_merchant(merchant_id)
    item_id = highest_revenue_item_id(items)
    sales_engine.items.find_by_id(item_id)
  end
end
