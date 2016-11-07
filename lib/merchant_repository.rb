class MerchantRepository
  attr_reader :all,
              :sales_engine

  def initialize(sales_engine)
    @all = []
    @sales_engine = sales_engine
  end

  def <<(merchant)
    all.push(merchant)
  end

  def add_merchants(data)
    data.each do |row|
      all << Merchant.new(row, sales_engine)
    end
  end

  def find_by_id(merchant_id)
    all.find do |merchant|
      merchant.id == merchant_id.to_i
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

  def inspect; end
end
