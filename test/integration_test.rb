require 'minitest/autorun'
require 'minitest/pride'
require './lib/sales_engine'
require './lib/merchant_repository'
require './lib/item_repository'

class SalesEngineTest < Minitest::Test

  def test_merchants_can_find_their_items
    sales_engine = SalesEngine.from_csv({
      :merchants => './test/fixtures/merchant_fixture.csv',
      :items => './test/fixtures/item_fixture.csv'
    })
    merchant_id = 12341234
    merchant = sales_engine.merchants.find_by_id(merchant_id)
    items = sales_engine.items.find_all_by_merchant_id(merchant_id)
    assert_equal items, merchant.items
  end

  def test_items_can_find_their_merchant
    sales_engine = SalesEngine.from_csv({
      :merchants => './test/fixtures/merchant_fixture.csv',
      :items => './test/fixtures/item_fixture.csv'
    })
    merchant_id = 12341234
    merchant = sales_engine.merchants.find_by_id(merchant_id)
    item = sales_engine.items.find_all_by_merchant_id(merchant_id).first
    # require 'pry'; binding.pry
    assert_equal merchant, item.merchant
  end
end
