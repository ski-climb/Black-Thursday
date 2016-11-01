class Item

  attr_reader :id,
              :name,
              :description,
              :merchant_id

  def initialize(data)
    @id = data[:id]
    @name = data[:name]
    @description = data[:description]
    @merchant_id = data[:merchant_id]
  end

end