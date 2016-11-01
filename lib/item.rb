class Item

  attr_reader :id,
              :name,
              :description,
              :merchant_id

  def initialize(id, name, description, merchant_id)
    @id = id
    @name = name
    @description = description
    @merchant_id = merchant_id
  end

end