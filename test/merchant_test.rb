require 'minitest/autorun'
require 'minitest/pride'
require './lib/merchant'

class MerchantTest < Minitest::Test

  def test_it_exists
    assert Merchant.new
  end

  def test_merchants_have_ids
    merchant_id = 12345678
    m = Merchant.new(id: merchant_id)
    assert_equal merchant_id, m.id
  end

  def test_default_id_for_merchants_is_000_000_00
    merchant_id = nil
    m = Merchant.new(id: merchant_id)
    assert_equal 000_000_00, m.id
  end

  def test_merchants_have_names
    merchant_name = "IronCompassFlight"
    m = Merchant.new(name: merchant_name)
    assert_equal merchant_name, m.name
  end

  def test_merchants_have_default_name
    merchant_name = nil
    m = Merchant.new(name: merchant_name)
    assert_equal "No Merchant Name", m.name
  end
end
