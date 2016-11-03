require 'bigdecimal'
require_relative './test_helper.rb'
require_relative '../lib/sales_analyst'
require_relative '../lib/sales_engine'
require_relative '../lib/importer'

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

  def test_it_calculates_average_items_per_merchant_standard_deviation
    assert_equal 1.25, @fixture_analyst.average_items_per_merchant_standard_deviation
  end

  def test_it_calculates_merchants_with_high_item_count
    merchant = @sales_engine.merchants.find_by_id(12341234)
    assert_equal [merchant], @fixture_analyst.merchants_with_high_item_count
  end

  def test_it_calculates_average_item_price_for_merchant
    merchant_id = 12341234
    assert_equal 141.42, @fixture_analyst.average_item_price_for_merchant(merchant_id).to_f
    assert_instance_of BigDecimal, @fixture_analyst.average_item_price_for_merchant(merchant_id)
  end
end
