class SalesAnalyst
  attr_reader :sales_engine

  def initialize(sales_engine)
    @sales_engine = sales_engine
  end

  def average_items_per_merchant
    result = total_number_of_items / total_number_of_merchants.to_f
    result.round(2)
  end

  def average_items_per_merchant_standard_deviation
    numerator = all_merchants.map do |merchant|
      (merchant.items.length - average_items_per_merchant)**2
    end.reduce(:+)
    denominator = total_number_of_merchants - 1
    result = Math::sqrt(numerator / denominator)
    return result.round(2)
  end

  def merchants_with_high_item_count
    all_merchants.find_all do |merchants|
      merchants.items.length >= 7
    end
  end

  def total_number_of_items
    sales_engine.items.all.length
  end

  def total_number_of_merchants
    sales_engine.merchants.all.length
  end

  def all_merchants
    sales_engine.merchants.all
  end
end
