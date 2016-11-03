require_relative './test_helper.rb'
require_relative '../lib/merchant'

class MerchantTest < Minitest::Test

  def setup
    merchant_id = 12345678
    merchant_name = "IronCompassFlight"
    sales_engine = SalesEngine
    @merchant = Merchant.new({
      :id => merchant_id,
      :name => merchant_name,
      :sales_engine => sales_engine
    })
  end

  def test_merchants_have_ids
    assert_equal 12345678, @merchant.id
  end

  def test_merchants_have_names
    assert_equal "IronCompassFlight", @merchant.name
  end

  def test_merchants_point_to_the_sales_engine
    assert_kind_of Class, @merchant.sales_engine
  end

  def test_merchants_respond_to_items_method
    assert_respond_to @merchant, :items
  end
  
  def test_merchants_respond_to_invoices_method
    assert_respond_to @merchant, :invoices
  end
end
