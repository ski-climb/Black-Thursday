require_relative './sales_analyst'
require_relative './sales_analyst_helper'

module MerchantAnalyst
  include SalesAnalystHelper

  def all_merchants
    sales_engine.merchants.all
  end

  def total_number_of_merchants
    all_merchants.count
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

  def merchants_with_high_item_count
    plus_one_standard_deviation = items_per_merchant_standard_deviations(1)
    all_merchants.find_all do |merchant|
      merchant.items.count >= plus_one_standard_deviation
    end
  end

  def items_per_merchant_standard_deviations(num)
    average_items_per_merchant + \
      num * average_items_per_merchant_standard_deviation
  end

  def average_items_per_merchant
    result = total_number_of_items / total_number_of_merchants.to_f
    result.round(2)
  end

  def average_invoices_per_merchant
    result = total_number_of_invoices / total_number_of_merchants.to_f
    result.round(2)
  end

  def merchants_ranked_by_revenue
    all_merchants.sort_by do |merchant|
      revenue_by_merchant(merchant.id).to_f
    end.reverse
  end

  def sum_of_average_prices_for_all_merchants
    all_merchants.map do |merchant|
      average_item_price_for_merchant(merchant.id)
    end.reduce(:+)
  end

  def paid_invoice_ids_by_merchant(merchant)
    merchant.invoices.find_all do |invoice|
      invoice.is_paid_in_full?
    end.map(&:id)
  end

  def merchants_created_in_month(month)
    all_merchants.find_all do |merchant|
      merchant.created_at_month == month
    end
  end
end
