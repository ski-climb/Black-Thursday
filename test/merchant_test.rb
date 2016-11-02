require 'minitest/autorun'
require 'minitest/pride'
require './lib/merchant'

class MerchantTest < Minitest::Test

  def test_merchants_have_ids
    merchant_id = 12345678
    merchant_name = "IronCompassFlight"
    m = Merchant.new({
      :id => merchant_id,
      :name => merchant_name
    })
    assert_equal merchant_id.to_s, m.id
  end

  def test_merchants_have_names
    merchant_id = 12345678
    merchant_name = "IronCompassFlight"
    m = Merchant.new({
      :id => merchant_id,
      :name => merchant_name
    })
    assert_equal merchant_name, m.name
  end

  def test_merchants_know_which_items_they_sell
    skip
    # insert mock for salesengine.find_items_by_merchant_id here
  end

end
