class SalesAnalyst
  attr_reader :sales_engine

  def initialize(sales_engine)
    @sales_engine = sales_engine
  end

  def average_items_per_merchant
    result = number_of_items / number_of_merchants.to_f
    result.round(2)
  end

  def number_of_items
    sales_engine.items.all.length
  end

  def number_of_merchants
    sales_engine.merchants.all.length
  end
end
