class ItemRepository
  attr_reader :all

  def initialize
    @all = []
  end

  def <<(item)
    all.push(item)
  end

  def find_by_id(id)
    all.find do |item|
      item.id == id.to_s
    end
  end

  def find_by_name(name)
    all.find do |item|
      item.name.downcase == name.downcase
    end
  end

  def find_all_with_description(description_stub)
    all.find_all do |item|
      item.description.downcase.include?(description_stub.downcase)
    end
  end

  def find_all_by_merchant_id(id)
    all.find_all do |item|
      item.merchant_id == id.to_s
    end
  end
end
