require 'chronic'

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
    @created_at = Chronic.parse(data[:created_at] + " 00:00:00")
    @updated_at = Chronic.parse(data[:updated_at] + " 00:00:00")
    @sales_engine = sales_engine
  end

  def merchant
    sales_engine.find_merchant_by_invoice_id(merchant_id)
  end

end
