require_relative './test_helper'
require_relative '../lib/customer_repository'
require_relative '../lib/customer'

class CustomerRepositoryTest < Minitest::Test

  def setup
    @sales_engine = Minitest::Mock.new
    @customer_repository = CustomerRepository.new(@sales_engine)
    customer_1 = Customer.new({
      :id => 1234,
      :first_name => "Ted",
      :last_name => "Tester",
      :created_at => '2012-03-27 14:54:09 UTC',
      :updated_at => '2012-03-27 14:54:09 UTC'
    }, @sales_engine)
    customer_2 = Customer.new({
      :id => 123,
      :first_name => "Ted",
      :last_name => "Smith",
      :created_at => '2012-03-27 14:54:09 UTC',
      :updated_at => '2012-03-27 14:54:09 UTC'
    }, @sales_engine)
    customer_3 = Customer.new({
      :id => 12,
      :first_name => "Sarah",
      :last_name => "Tester",
      :created_at => '2012-03-27 14:54:09 UTC',
      :updated_at => '2012-03-27 14:54:09 UTC'
    }, @sales_engine)
    @customer_repository << customer_1
    @customer_repository << customer_2
    @customer_repository << customer_3
  end

  def test_it_exists
    assert @customer_repository
  end

  def test_it_has_no_customers_when_initialized
    customer_repository = CustomerRepository.new(@sales_engine)
    assert_equal [], customer_repository.all
  end

  def test_customers_can_be_added_to_the_repository
    assert_equal 3, @customer_repository.all.count
    assert @customer_repository.all.map(&:first_name).include?("Ted")
    assert @customer_repository.all.map(&:first_name).include?("Sarah")
  end

  def test_it_returns_nil_when_no_customers_have_given_id
    assert_nil @customer_repository.find_by_id(1_000_000)
  end

  def test_it_returns_an_empty_array_when_no_customers_have_given_first_name
    assert_equal [], @customer_repository.find_all_by_first_name("Dick")
  end

  def test_it_returns_an_empty_array_when_no_customers_have_given_last_name
    assert_equal [], @customer_repository.find_all_by_last_name("Butkus")
  end

  def test_it_can_find_a_customer_by_the_id
    assert_equal "Sarah", @customer_repository.find_by_id(12).first_name
  end

  def test_it_can_find_all_customers_with_given_first_name
    first_name = "Ted"
    results = @customer_repository.find_all_by_first_name(first_name)
    assert_equal 2, results.count
    assert_equal first_name, results.map(&:first_name).uniq.first
  end

  def test_it_can_find_all_customers_with_given_last_name
    last_name = "Tester"
    results = @customer_repository.find_all_by_last_name(last_name)
    assert_equal 2, results.count
    assert_equal last_name, results.map(&:last_name).uniq.first
  end
end
