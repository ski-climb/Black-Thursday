require 'chronic'
require 'bigdecimal'
require './lib/sales_engine'

class Item

  attr_reader :id,
              :name,
              :description,
              :merchant_id,
              :unit_price,
              :created_at,
              :updated_at,
              :sales_engine

  def initialize(data)
    @id = data[:id].to_s
    @name = data[:name]
    @description = data[:description]
    @merchant_id = data[:merchant_id].to_s
    @unit_price = BigDecimal.new(data[:unit_price], 4)
    @created_at = Chronic.parse(data[:created_at])
    @updated_at = Chronic.parse(data[:updated_at])
    @sales_engine = data[:sales_engine]
  end

  def unit_price_to_dollars
    (unit_price / BigDecimal(100)).to_f
  end

  def merchant
    sales_engine.find_merchant_by_item_id(merchant_id)
  end

end
