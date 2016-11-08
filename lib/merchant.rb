require_relative './sales_engine'

class Merchant

  attr_reader :id,
              :name,
              :sales_engine,
              :created_at,
              :updated_at

  def initialize(data, sales_engine)
    @id = data[:id].to_i
    @name = data[:name]
    @created_at = Time.parse(data[:created_at])
    @updated_at = Time.parse(data[:updated_at])
    @sales_engine = sales_engine
  end

  def created_at_month
    created_at.strftime('%B')
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
