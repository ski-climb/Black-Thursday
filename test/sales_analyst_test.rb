require 'minitest/autorun'
require 'minitest/pride'
require './lib/sales_analyst'
require './lib/sales_engine'

class SalesAnalystTest < Minitest::Test

  def setup
    @sales_engine = SalesEngine.from_csv({
      :items =>     './test/fixtures/item_fixture.csv',
      :merchants => './test/fixtures/merchant_fixture.csv'
    })
    @fixture_analyst = SalesAnalyst.new(@sales_engine)
  end

  def test_it_exists
    sales_engine = SalesEngine
    assert SalesAnalyst.new(sales_engine)
  end

  def test_it_calculates_average_items_per_merchant
    assert_equal 0.38, @fixture_analyst.average_items_per_merchant
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
    assert_equal 1.25, @fixture_analyst.average_items_per_merchant_standard_deviation
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
    merchant = @sales_engine.merchants.find_by_id(12341234)
    assert_equal [merchant], @fixture_analyst.merchants_with_high_item_count
  end

  def test_it_calculates_merchants_with_high_item_count_using_provided_data
    skip "for speed!"
    sales_engine = SalesEngine.from_csv({
      :items =>     './data/items.csv',
      :merchants => './data/merchants.csv'
    })
    analyst = SalesAnalyst.new(sales_engine)
    assert_equal 52, analyst.merchants_with_high_item_count.length
    assert_instance_of Merchant, analyst.merchants_with_high_item_count.first
  end

  def test_it_calculates_average_item_price_for_merchant
    merchant_id = 12341234
    assert_equal 139.0, @fixture_analyst.average_item_price_for_merchant(merchant_id)
    assert_instance_of BigDecimal, @fixture_analyst.average_item_price_for_merchant(merchant_id)
  end

  def test_it_calculates_average_average_price_per_merchant
    skip "for speed!"
    sales_engine = SalesEngine.from_csv({
      :items =>     './data/items.csv',
      :merchants => './data/merchants.csv'
    })
    analyst = SalesAnalyst.new(sales_engine)
    assert_equal 350.29, analyst.average_average_price_per_merchant.to_f
    assert_instance_of BigDecimal, analyst.average_average_price_per_merchant
  end

  def test_it_finds_the_golden_items
    skip "for speed!"
    sales_engine = SalesEngine.from_csv({
      :items =>     './data/items.csv',
      :merchants => './data/merchants.csv'
    })
    analyst = SalesAnalyst.new(sales_engine)
    assert_equal 5, @fixture_analyst.golden_items.length
    assert_instance_of Item, @fixture_analyst.golden_items.first
  end

end
