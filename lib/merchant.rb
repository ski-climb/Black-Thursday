require_relative './sales_engine'

class Merchant

  attr_reader :id,
              :name,
              :sales_engine

  def initialize(data, sales_engine)
    @id = data[:id].to_i
    @name = data[:name]
    @sales_engine = sales_engine
  end

  def items
    sales_engine.find_items_by_merchant_id(id)
  end

  def invoices
    sales_engine.find_invoices_by_merchant_id(id)
  end

  def customers
    sales_engine.find_customers_by_merchant_id(id)
  end

  def has_pending_invoice?
    invoices.any? do |invoice|
      !invoice.is_paid_in_full?
    end
  end
end
