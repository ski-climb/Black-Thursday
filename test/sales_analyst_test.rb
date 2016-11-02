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
    assert_equal 0.34, analyst.average_items_per_merchant
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
    assert_equal 1.08, analyst.average_items_per_merchant_standard_deviation
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
end
