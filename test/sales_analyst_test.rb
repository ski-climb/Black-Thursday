require 'minitest/autorun'
require 'minitest/pride'
require './lib/sales_analyst'
require './lib/sales_engine'

class SalesAnalystTest < Minitest::Test

  def test_it_exists
    sales_engine = SalesEngine
    assert SalesAnalyst.new(sales_engine)
  end

  def test_it_calculates_average_items_per_merchant
    sales_engine = SalesEngine.from_csv({
      :items =>     './test/fixtures/item_fixture.csv',
      :merchants => './test/fixtures/merchant_fixture.csv'
    })
    analyst = SalesAnalyst.new(sales_engine)
    assert_equal 0.38, analyst.average_items_per_merchant
  end

  def test_it_calculates_average_items_per_merchant_using_provided_data
    skip "for speed!"
    sales_engine = SalesEngine.from_csv({
      :items =>     './data/items.csv',
      :merchants => './data/merchants.csv'
    })
    analyst = SalesAnalyst.new(sales_engine)
    assert_equal 2.88, analyst.average_items_per_merchant
  end

  def test_it_calculates_average_items_per_merchant_standard_deviation
    sales_engine = SalesEngine.from_csv({
      :items =>     './test/fixtures/item_fixture.csv',
      :merchants => './test/fixtures/merchant_fixture.csv'
    })
    analyst = SalesAnalyst.new(sales_engine)
    assert_equal 1.25, analyst.average_items_per_merchant_standard_deviation
  end

  def test_it_calculates_average_items_per_merchant_standard_deviation_using_provided_data
    skip "for speed!"
    sales_engine = SalesEngine.from_csv({
      :items =>     './data/items.csv',
      :merchants => './data/merchants.csv'
    })
    analyst = SalesAnalyst.new(sales_engine)
    assert_equal 3.26, analyst.average_items_per_merchant_standard_deviation
  end
  
  def test_it_calculates_merchants_with_high_item_count
    sales_engine = SalesEngine.from_csv({
      :items =>     './test/fixtures/item_fixture.csv',
      :merchants => './test/fixtures/merchant_fixture.csv'
    })
    analyst = SalesAnalyst.new(sales_engine)
    merchant = sales_engine.merchants.find_by_id(12341234)
    assert_equal [merchant], analyst.merchants_with_high_item_count
  end

  def test_it_calculates_merchants_with_high_item_count_using_provided_data
    skip "for speed!"
    sales_engine = SalesEngine.from_csv({
      :items =>     './data/items.csv',
      :merchants => './data/merchants.csv'
    })
    analyst = SalesAnalyst.new(sales_engine)
    assert_equal 52, analyst.merchants_with_high_item_count.length
  end
end
