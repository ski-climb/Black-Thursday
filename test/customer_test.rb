require_relative './test_helper.rb'
require_relative '../lib/customer'

class CustomerTest < Minitest::Test

  def setup
    customer_id = 6
    customer_first_name = "Michael"
    customer_last_name = "Myers"
    customer_created_at = '2013-03-27 14:54:09 UTC'
    customer_updated_at = '2012-02-26 20:56:56 UTC'
    @sales_engine = Minitest::Mock.new
    @customer = Customer.new({
      :id => customer_id,
      :first_name => customer_first_name,
      :last_name => customer_last_name,
      :created_at => customer_created_at,
      :updated_at => customer_updated_at
    }, @sales_engine)
  end

  def test_customer_has_an_id
    assert_equal 6, @customer.id
  end

  def test_customer_has_a_first_name
    assert_equal "Michael", @customer.first_name
  end

  def test_customer_has_a_last_name
    assert_equal "Myers", @customer.last_name
  end

  def test_customer_points_to_sales_engine
    assert @customer.sales_engine
  end

  def test_it_has_a_created_at
    created_at = Time.gm(2013, 3, 27, 14, 54, 9)
    assert_equal created_at, @customer.created_at
  end

  def test_it_has_a_updated_at
    updated_at = Time.gm(2012, 2, 26, 20, 56, 56)
    assert_equal updated_at, @customer.updated_at
  end

  def test_it_responds_to_merchants
    assert_respond_to @customer, :merchants
  end

  def test_it_has_merchants
    merchant = Minitest::Mock.new
    @sales_engine.expect(:find_merchants_by_customer_id, [merchant], [@customer.id])
    @customer.merchants
    @sales_engine.verify
  end
end
