require_relative './sales_engine'

class Merchant

  attr_reader :id,
              :name,
              :sales_engine

  def initialize(data)
    @id = data[:id].to_i
    @name = data[:name]
    @sales_engine = data[:sales_engine]
  end

  def items
    sales_engine.find_items_by_merchant_id(id)
  end

  def invoices
    sales_engine.find_invoices_by_merchant_id(id)
  end
end
