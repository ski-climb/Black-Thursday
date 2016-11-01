require 'minitest/autorun'
require 'minitest/pride'
require './lib/sales_engine'
require './lib/merchant_repository'

class SalesEngineTest < Minitest::Test

  def test_it_exists
    assert SalesEngine.new
  end

  def test_it_responds_to_from_csv
    assert SalesEngine.from_csv({})
  end

  def test_from_csv_can_take_a_hash_of_arguments
    assert SalesEngine.from_csv({
      :items =>     './test/fixtures/item_fixture.csv',
      :merchants => './test/fixtures/merchant_fixture.csv'
    })
  end

  def test_it_returns_a_merchant_repo
    path_and_filename = './test/fixtures/merchant_fixture.csv'
    sales_engine = SalesEngine.from_csv({:merchants => path_and_filename})
    assert_instance_of MerchantRepository, sales_engine.merchants
  end

  def test_it_can_create_merchants_for_each_line_of_the_csv
    number_of_merchants_in_file = 32
    sales_engine = SalesEngine.from_csv({
      :merchants => './test/fixtures/merchant_fixture.csv'
    })
    assert_equal number_of_merchants_in_file, sales_engine.merchants.all.length
    assert sales_engine.merchants.find_by_name("VectorCoast")
  end
end
