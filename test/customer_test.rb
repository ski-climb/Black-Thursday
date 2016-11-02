require 'minitest/autorun'
require 'minitest/pride'
require './lib/customer'

class CustomerTest < Minitest::Test

  def setup
    @customer_id = 6
    @customer_first_name = "Michael"
    @customer_last_name = "Myers"
    @customer_created_at = '2013-03-27 14:54:09 UTC'
    @customer_updated_at = '2012-02-26 20:56:56 UTC'
    @customer = Customer.new({
      :id => @customer_id,
      :first_name => @customer_first_name,
      :last_name => @customer_last_name,
      :created_at => @customer_created_at,
      :updated_at => @customer_updated_at
    })
  end

  def test_customer_has_an_id
    assert_equal @customer_id.to_s, @customer.id
  end

  def test_customer_has_a_first_name
    assert_equal @customer_first_name, @customer.first_name
  end

  def test_customer_has_a_last_name
    assert_equal @customer_last_name, @customer.last_name
  end

  def test_it_has_a_created_at
    created_at = Time.gm(2013, 3, 27, 14, 54, 9)
    assert_equal created_at, @customer.created_at
  end

  def test_it_has_a_updated_at
    updated_at = Time.gm(2012, 2, 26, 20, 56, 56)
    assert_equal updated_at, @customer.updated_at
  end
end
