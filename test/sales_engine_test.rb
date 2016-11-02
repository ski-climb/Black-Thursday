require 'minitest/autorun'
require 'minitest/pride'
require './lib/sales_engine'
require './lib/merchant_repository'
require './lib/item_repository'

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

  def test_it_returns_an_item_repo
    path_and_filename = './test/fixtures/item_fixture.csv'
    sales_engine = SalesEngine.from_csv({:items => path_and_filename})
    assert_instance_of ItemRepository, sales_engine.items
  end

  def test_it_can_create_items_for_each_line_of_the_csv
    number_of_items_in_file = 11
    sales_engine = SalesEngine.from_csv({
      :items => './test/fixtures/item_fixture.csv'
    })
    assert_equal number_of_items_in_file, sales_engine.items.all.length
    assert sales_engine.items.find_by_name("Anello nodo")
  end

  def test_it_can_import_the_provided_file_for_merchants
    sales_engine = SalesEngine.from_csv({
      :merchants => './data/merchants.csv'
    })
    assert_equal 475, sales_engine.merchants.all.length
    assert sales_engine.merchants.all.map(&:name).include?('Woodenpenshop')
  end

  def test_it_can_import_the_provided_file_for_items
    skip
    # skipped for speed!
    sales_engine = SalesEngine.from_csv({
      :items => './data/items.csv'
    })
    assert_equal 1367, sales_engine.items.all.length
    assert sales_engine.items.all.map(&:name).include?('wooden finger protection')
  end

  def test_it_can_find_items_by_merchant_id
    merchant_id = 12341234
    sales_engine = SalesEngine.from_csv({
      :items => './test/fixtures/item_fixture.csv'
    })
    results = sales_engine.find_items_by_merchant_id(merchant_id)
    assert_equal 6, results.length
  end

  def test_find_items_by_id_only_returns_items_for_specified_merchant
    merchant_id = 12341234
    sales_engine = SalesEngine.from_csv({
      :items => './test/fixtures/item_fixture.csv'
    })
    results = sales_engine.find_items_by_merchant_id(merchant_id)
    assert_equal 1, results.map(&:merchant_id).uniq.length
    assert_equal merchant_id.to_s, results.map(&:merchant_id).uniq.first
  end
end
