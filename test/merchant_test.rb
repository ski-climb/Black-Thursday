require 'minitest/autorun'
require 'minitest/pride'
require './lib/merchant'

class MerchantTest < Minitest::Test

  def setup
    merchant_id = 12345678
    merchant_name = "IronCompassFlight"
    @merchant = Merchant.new({
      :id => merchant_id,
      :name => merchant_name
    })
  end

  def test_merchants_have_ids
    assert_equal '12345678', @merchant.id
  end

  def test_merchants_have_names
    assert_equal "IronCompassFlight", @merchant.name
  end

  def test_merchants_know_which_items_they_sell
    skip
    sales_engine = Minitest::Mock.new
    sales_engine.expect(:find_items_by_merchant_id, [], [12])
    @merchant.items
    sales_engine.verify
  end

end
