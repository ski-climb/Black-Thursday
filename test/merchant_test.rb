require 'minitest/autorun'
require 'minitest/pride'
require './lib/merchant'

class MerchantTest < Minitest::Test

  def test_merchants_have_ids
    merchant_id = 12345678
    merchant_name = "IronCompassFlight"
    m = Merchant.new(merchant_id, merchant_name)
    assert_equal merchant_id, m.id
  end

  def test_merchants_have_names
    merchant_id = 12345678
    merchant_name = "IronCompassFlight"
    m = Merchant.new(merchant_id, merchant_name)
    assert_equal merchant_name, m.name
  end

end
