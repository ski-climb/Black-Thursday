require 'chronic'
require 'bigdecimal'

class Item

  attr_reader :id,
              :name,
              :description,
              :merchant_id,
              :unit_price,
              :created_at,
              :updated_at

  def initialize(data)
    @id = data[:id]
    @name = data[:name]
    @description = data[:description]
    @merchant_id = data[:merchant_id]
    @unit_price = BigDecimal.new(data[:unit_price], 4) / BigDecimal.new(100)
    @created_at = Chronic.parse(data[:created_at])
    @updated_at = Chronic.parse(data[:updated_at])
  end

end
