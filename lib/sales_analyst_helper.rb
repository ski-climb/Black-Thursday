module SalesAnalystHelper

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
end
