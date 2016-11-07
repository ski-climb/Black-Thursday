module SalesAnalystHelper

  def all_items
    sales_engine.items.all
  end

  def all_merchants
    sales_engine.merchants.all
  end

  def all_invoices
    sales_engine.invoices.all
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

  def total_price_for_all_items
    all_items.map do |item|
      item.unit_price
    end.reduce(:+)
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

  def unit_price_per_item
    all_items.map do |item|
      item.unit_price
    end
  end

  def invoices_per_day_of_week
    invoices_sorted_by_day_of_week.map do |key, value|
      value.length
    end
  end

  def invoice_count_by_day_of_week
    result = {}
    invoices_sorted_by_day_of_week.each do |key, value|
      result[@weekdays[key]] = value.length
    end
    result
  end

  def items_per_merchant_standard_deviations(num)
    average_items_per_merchant + \
      num * average_items_per_merchant_standard_deviation
  end

  def price_per_item_standard_deviations(num)
    average_unit_price_per_item + \
      num * average_unit_price_per_item_standard_deviation
  end

  def invoices_per_day_standard_deviation(num)
    average_invoices_per_day_of_week + \
      num * average_invoices_per_day_standard_deviation
  end

  def invoices_per_merchant_standard_deviation(num)
    average_invoices_per_merchant + \
      num * average_invoices_per_merchant_standard_deviation
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
      average_invoices_per_day_of_week,
      @weekdays.length)
    .round(2)
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

  def invoices_sorted_by_day_of_week
    all_invoices.group_by do |invoice|
      invoice.created_at.wday
    end
  end

  def average_invoices_per_day_of_week
    result = total_number_of_invoices / @weekdays.length.to_f
  end

  def successfully_charged_total_by_invoice(invoices)
    invoices.find_all do |invoice|
      sales_engine.successfully_charged_total_for_invoice(invoice.id) != 0
    end
  end

  def sum_of_successful_charges_for_invoices(invoices)
    successfully_charged_total_by_invoice(invoices).map do |invoice|
      sales_engine.total_cost_of_all_items_on_invoice(invoice.id)
    end
    .reduce(:+)
  end
end
