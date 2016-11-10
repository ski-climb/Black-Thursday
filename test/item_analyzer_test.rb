require 'bigdecimal'
require_relative './test_helper.rb'
require_relative '../lib/sales_engine'
require_relative '../lib/sales_analyst'
require_relative '../lib/merchant_repository'
require_relative '../lib/item_repository'

class ItemAnalyzerTest < Minitest::Test

  def test_it_can_import_the_provided_file_for_items
    sales_engine = SalesEngine.from_csv({
      :items =>     './data/items.csv',
      :merchants => './data/merchants.csv'
    })
    assert_equal 1367, sales_engine.items.all.count
    assert sales_engine.items.all.map(&:name).include?('wooden finger protection')
  end

  def test_an_item_can_find_its_merchant
    sales_engine = SalesEngine.from_csv({
      :merchants => './test/fixtures/merchant_fixture.csv',
      :items => './test/fixtures/item_fixture.csv'
    })
    merchant_id = 12341234
    merchant = sales_engine.merchants.find_by_id(merchant_id)
    item = sales_engine.items.find_all_by_merchant_id(merchant_id).first
    assert_equal merchant, item.merchant
  end

  def test_it_finds_the_golden_items
    sales_engine = SalesEngine.from_csv({
      :items =>     './data/items.csv',
      :merchants => './data/merchants.csv'
    })
    analyst = SalesAnalyst.new(sales_engine)
    assert_equal 5, analyst.golden_items.count
    assert_instance_of Item, analyst.golden_items.first
  end
end
