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
      :created_at => '2009-05-30',
      :updated_at => '2012-07-25'
    }, sales_engine)
  end

  def test_it_has_ids
    assert_equal 12345678, @merchant.id
  end

  def test_it_has_names
    assert_equal "IronCompassFlight", @merchant.name
  end

  def test_it_has_created_at
    assert_equal Time.parse('2009-05-30'), @merchant.created_at
  end

  def test_it_has_updated_at
    assert_equal Time.parse('2012-07-25'), @merchant.updated_at
  end

  def test_it_points_to_the_sales_engine
    assert_kind_of Class, @merchant.sales_engine
  end

  def test_it_responds_to_items_method
    assert_respond_to @merchant, :items
  end
  
  def test_it_responds_to_invoices_method
    assert_respond_to @merchant, :invoices
  end

  def test_it_responds_to_custoomers
    assert_respond_to @merchant, :customers
  end

  def test_it_has_created_at_month
    assert_equal "May", @merchant.created_at_month
  end
end
