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
    sales_engine.find_merchant_by_invoice_id(merchant_id)
  end

  def transactions
    sales_engine.find_transactions_by_invoice_id(id)
  end

  def customer
    sales_engine.find_customer_by_invoice_id(customer_id)
  end
end
