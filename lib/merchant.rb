require './lib/sales_engine'

class Merchant

  attr_reader :id,
              :name

  def initialize(data)
    @id = data[:id].to_s
    @name = data[:name]
  end

  def items
    require 'pry'; binding.pry
    SalesEngine.items.find_items_by_merchant_id(id)
  end

end
