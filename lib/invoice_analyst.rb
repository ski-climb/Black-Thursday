require_relative './sales_analyst'
require_relative './sales_analyst_helper'

module InvoiceAnalyst
  include SalesAnalystHelper

  def all_invoices
    sales_engine.invoices.all
  end

  def total_number_of_invoices
    all_invoices.count
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

  def invoices_sorted_by_day_of_week
    all_invoices.group_by do |invoice|
      invoice.created_at.wday
    end
  end

  def average_invoices_per_day_of_week
    total_number_of_invoices / @weekdays.length.to_f
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
