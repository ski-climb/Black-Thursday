require 'bigdecimal'
require_relative './test_helper.rb'
require_relative '../lib/sales_engine'
require_relative '../lib/sales_analyst'
require_relative '../lib/merchant_repository'
require_relative '../lib/item_repository'

class IntegrationTest < Minitest::Test

  def test_merchants_can_find_their_items
    sales_engine = SalesEngine.from_csv({
      :merchants => './test/fixtures/merchant_fixture.csv',
      :items => './test/fixtures/item_fixture.csv'
    })
    merchant_id = 12341234
    merchant = sales_engine.merchants.find_by_id(merchant_id)
    items = sales_engine.items.find_all_by_merchant_id(merchant_id)
    assert_equal items, merchant.items
  end

  def test_merchants_can_find_their_invoices
    sales_engine = SalesEngine.from_csv({
      :merchants => './test/fixtures/merchant_fixture.csv',
      :invoices => './test/fixtures/invoice_fixture.csv'
    })
    merchant_id = 12341234
    merchant = sales_engine.merchants.find_by_id(merchant_id)
    invoices = sales_engine.invoices.find_all_by_merchant_id(merchant_id)
    assert_equal invoices, merchant.invoices
  end

  def test_an_item_can_find_its_merchant
    sales_engine = SalesEngine.from_csv({
      :merchants => './test/fixtures/merchant_fixture.csv',
      :items => './test/fixtures/item_fixture.csv'
    })
    merchant_id = 12341234
    merchant = sales_engine.merchants.find_by_id(merchant_id)
    item = sales_engine.items.find_all_by_merchant_id(merchant_id).first
    assert_equal merchant, item.merchant
  end

  def test_an_invoice_can_find_its_merchant
    sales_engine = SalesEngine.from_csv({
      :merchants => './test/fixtures/merchant_fixture.csv',
      :invoices => './test/fixtures/invoice_fixture.csv'
    })
    merchant_id = 12341234
    merchant = sales_engine.merchants.find_by_id(merchant_id)
    invoice = sales_engine.invoices.find_all_by_merchant_id(merchant_id).first
    assert_equal merchant, invoice.merchant
  end

  def test_it_can_import_the_provided_file_for_merchants
    skip "for speed!"
    sales_engine = SalesEngine.from_csv({
      :items =>     './data/items.csv',
      :merchants => './data/merchants.csv'
    })
    assert_equal 475, sales_engine.merchants.all.length
    assert sales_engine.merchants.all.map(&:name).include?('Woodenpenshop')
  end

  def test_it_can_import_the_provided_file_for_items
    skip "for speed!"
    sales_engine = SalesEngine.from_csv({
      :items =>     './data/items.csv',
      :merchants => './data/merchants.csv'
    })
    assert_equal 1367, sales_engine.items.all.length
    assert sales_engine.items.all.map(&:name).include?('wooden finger protection')
  end

  def test_it_can_import_the_provided_file_for_items
    skip "for speed!"
    sales_engine = SalesEngine.from_csv({
      :invoices => './data/invoices.csv'
    })
    results = sales_engine.invoices
    assert_equal 4985, results.all.length
    assert results.find_by_id(6)
    assert results.find_by_id(4977)
  end

  def test_it_calculates_average_items_per_merchant_using_provided_data
    skip "for speed!"
    sales_engine = SalesEngine.from_csv({
      :items =>     './data/items.csv',
      :merchants => './data/merchants.csv'
    })
    analyst = SalesAnalyst.new(sales_engine)
    assert_equal 2.88, analyst.average_items_per_merchant
  end

  def test_it_calculates_average_items_per_merchant_standard_deviation_using_provided_data
    skip "for speed!"
    sales_engine = SalesEngine.from_csv({
      :items =>     './data/items.csv',
      :merchants => './data/merchants.csv'
    })
    analyst = SalesAnalyst.new(sales_engine)
    assert_equal 3.26, analyst.average_items_per_merchant_standard_deviation
  end

  def test_it_calculates_merchants_with_high_item_count_using_provided_data
    skip "for speed!"
    sales_engine = SalesEngine.from_csv({
      :items =>     './data/items.csv',
      :merchants => './data/merchants.csv'
    })
    analyst = SalesAnalyst.new(sales_engine)
    assert_equal 52, analyst.merchants_with_high_item_count.length
    assert_instance_of Merchant, analyst.merchants_with_high_item_count.first
  end

  def test_it_calculates_average_average_price_per_merchant
    skip "for speed!"
    sales_engine = SalesEngine.from_csv({
      :items =>     './data/items.csv',
      :merchants => './data/merchants.csv'
    })
    analyst = SalesAnalyst.new(sales_engine)
    assert_equal 350.29, analyst.average_average_price_per_merchant.to_f
    assert_instance_of BigDecimal, analyst.average_average_price_per_merchant
  end

  def test_it_finds_the_golden_items
    skip "for speed!"
    sales_engine = SalesEngine.from_csv({
      :items =>     './data/items.csv',
      :merchants => './data/merchants.csv'
    })
    analyst = SalesAnalyst.new(sales_engine)
    assert_equal 5, analyst.golden_items.length
    assert_instance_of Item, analyst.golden_items.first
  end

  def test_it_calculates_average_invoices_per_merchant
    sales_engine = SalesEngine.from_csv({
      :merchants => './data/merchants.csv',
      :invoices => './data/invoices.csv'
    })
    analyst = SalesAnalyst.new(sales_engine)
    assert_equal 10.49, analyst.average_invoices_per_merchant
  end
end
