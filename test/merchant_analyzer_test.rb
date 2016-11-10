require 'bigdecimal'
require_relative './test_helper'
require_relative '../lib/sales_engine'
require_relative '../lib/sales_analyst'
require_relative '../lib/merchant_repository'
require_relative '../lib/item_repository'

class MerchantAnalyzerTest < Minitest::Test

  def test_it_can_import_the_provided_file_for_merchants
    sales_engine = SalesEngine.from_csv({
      :items =>     './data/items.csv',
      :merchants => './data/merchants.csv'
    })
    assert_equal 475, sales_engine.merchants.all.count
    assert sales_engine.merchants.all.map(&:name).include?('Woodenpenshop')
  end

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

  def test_it_calculates_average_items_per_merchant_using_provided_data
    sales_engine = SalesEngine.from_csv({
      :items =>     './data/items.csv',
      :merchants => './data/merchants.csv'
    })
    analyst = SalesAnalyst.new(sales_engine)
    assert_equal 2.88, analyst.average_items_per_merchant
  end

  def test_it_calculates_average_items_per_merchant_standard_deviation_using_provided_data
    sales_engine = SalesEngine.from_csv({
      :items =>     './data/items.csv',
      :merchants => './data/merchants.csv'
    })
    analyst = SalesAnalyst.new(sales_engine)
    assert_equal 3.26, analyst.average_items_per_merchant_standard_deviation
  end

  def test_it_calculates_merchants_with_high_item_count_using_provided_data
    sales_engine = SalesEngine.from_csv({
      :items =>     './data/items.csv',
      :merchants => './data/merchants.csv'
    })
    analyst = SalesAnalyst.new(sales_engine)
    assert_equal 52, analyst.merchants_with_high_item_count.count
    assert_instance_of Merchant, analyst.merchants_with_high_item_count.first
  end

  def test_it_calculates_average_average_price_per_merchant
    sales_engine = SalesEngine.from_csv({
      :items =>     './data/items.csv',
      :merchants => './data/merchants.csv'
    })
    analyst = SalesAnalyst.new(sales_engine)
    assert_equal 350.29, analyst.average_average_price_per_merchant.to_f
    assert_instance_of BigDecimal, analyst.average_average_price_per_merchant
  end

  def test_it_calculates_top_merchants_by_invoice_count
    sales_engine = SalesEngine.from_csv({
      :merchants => './data/merchants.csv',
      :invoices => './data/invoices.csv'
    })
    analyst = SalesAnalyst.new(sales_engine)
    results = analyst.top_merchants_by_invoice_count
    assert_equal 12, results.count
    assert_instance_of Merchant, results.first
  end

  def test_it_calculates_bottom_merchants_by_invoice_count
    sales_engine = SalesEngine.from_csv({
      :merchants => './data/merchants.csv',
      :invoices => './data/invoices.csv'
    })
    analyst = SalesAnalyst.new(sales_engine)
    results = analyst.bottom_merchants_by_invoice_count
    assert_equal 4, results.count
    assert_instance_of Merchant, results.first
  end

  def test_it_calculates_average_invoices_per_merchant
    sales_engine = SalesEngine.from_csv({
      :merchants => './data/merchants.csv',
      :invoices => './data/invoices.csv'
    })
    analyst = SalesAnalyst.new(sales_engine)
    assert_equal 10.49, analyst.average_invoices_per_merchant
  end

  def test_it_calculates_average_invoices_per_merchant_standard_deviation
    sales_engine = SalesEngine.from_csv({
      :merchants => './data/merchants.csv',
      :invoices => './data/invoices.csv'
    })
    analyst = SalesAnalyst.new(sales_engine)
    assert_equal 3.29, analyst.average_invoices_per_merchant_standard_deviation
  end
end
