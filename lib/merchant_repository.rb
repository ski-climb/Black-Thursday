class MerchantRepository
  attr_reader :all

  def initialize
    @all = []
  end

  def <<(merchant)
    all.push(merchant)
  end

  def find_by_id(id)
    all.find do |merchant|
      merchant.id == id.to_s
    end
  end

  def find_by_name(name)
    all.find do |merchant|
      merchant.name.downcase == name.downcase
    end
  end

  def find_all_by_name(name_stub)
    all.find_all do |merchant|
      merchant.name.downcase.include?(name_stub.downcase)
    end
  end

end





