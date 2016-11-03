require 'chronic'
require 'bigdecimal'
require_relative './sales_engine'

class Item

  attr_reader :id,
              :name,
              :description,
              :merchant_id,
              :unit_price,
              :created_at,
              :updated_at,
              :sales_engine

  def initialize(data, sales_engine)
    @id = data[:id].to_i
    @name = data[:name]
    @description = data[:description]
    @merchant_id = data[:merchant_id].to_i
    @unit_price = BigDecimal.new(data[:unit_price], 4) / 100
    @created_at = Chronic.parse(data[:created_at])
    @updated_at = Chronic.parse(data[:updated_at])
    @sales_engine = sales_engine
  end

  def unit_price_to_dollars
    unit_price.to_f
  end

  def merchant
    sales_engine.find_merchant_by_item_id(merchant_id)
  end

end
