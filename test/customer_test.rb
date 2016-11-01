require 'minitest/autorun'
require 'minitest/pride'
require './lib/customer'

class CustomerTest < Minitest::Test

  def setup
    @customer_id = 6
    @customer_first_name = "Michael"
    @customer_last_name = "Myers"
    @customer = Customer.new({
      :id => @customer_id,
      :first_name => @customer_first_name,
      :last_name => @customer_last_name
    })
  end

  def test_customer_has_an_id
    assert_equal @customer_id, @customer.id
  end

  def test_customer_has_a_first_name
    assert_equal @customer_first_name, @customer.first_name
  end

  def test_customer_has_a_last_name
    assert_equal @customer_last_name, @customer.last_name
  end

end