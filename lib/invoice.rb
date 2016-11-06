class Invoice

  attr_reader :id,
              :customer_id,
              :merchant_id,
              :status,
              :created_at,
              :updated_at,
              :sales_engine

  def initialize(data, sales_engine)
    @id = data[:id].to_i
    @customer_id = data[:customer_id].to_i
    @merchant_id = data[:merchant_id].to_i
    @status = data[:status].to_sym
    @created_at = Time.parse(data[:created_at])
    @updated_at = Time.parse(data[:updated_at])
    @sales_engine = sales_engine
  end

  def merchant
    sales_engine.find_merchant_by_id(merchant_id)
  end

  def transactions
    sales_engine.find_transactions_by_invoice_id(id)
  end

  def customer
    sales_engine.find_customer_by_id(customer_id)
  end

  def items
    sales_engine.find_items_by_invoice_id(id)
  end

  def is_paid_in_full?
    sales_engine.invoice_paid_in_full?(id)
  end
end
