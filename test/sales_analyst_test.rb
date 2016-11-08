require 'bigdecimal'
require_relative './test_helper.rb'
require_relative '../lib/sales_analyst'
require_relative '../lib/sales_engine'
require_relative '../lib/importer'

class SalesAnalystTest < Minitest::Test

  def setup
    @sales_engine = SalesEngine.from_csv({
      :items =>     './test/fixtures/item_fixture.csv',
      :merchants => './test/fixtures/merchant_fixture.csv'
    })
    @fixture_analyst = SalesAnalyst.new(@sales_engine)
  end

  def test_it_exists
    # skip
    sales_engine = SalesEngine
    assert SalesAnalyst.new(sales_engine)
  end

  def test_it_calculates_average_items_per_merchant
    # skip
    assert_equal 0.38, @fixture_analyst.average_items_per_merchant
  end

  def test_it_calculates_average_items_per_merchant_standard_deviation
    # skip
    assert_equal 1.25, @fixture_analyst.average_items_per_merchant_standard_deviation
  end

  def test_it_calculates_merchants_with_high_item_count
    # skip
    merchant = @sales_engine.merchants.find_by_id(12341234)
    assert_equal [merchant], @fixture_analyst.merchants_with_high_item_count
  end

  def test_it_calculates_average_item_price_for_merchant
    # skip
    merchant_id = 12341234
    assert_equal 141.42, @fixture_analyst.average_item_price_for_merchant(merchant_id).to_f
    assert_instance_of BigDecimal, @fixture_analyst.average_item_price_for_merchant(merchant_id)
  end

  def test_it_calculates_total_revenue_by_date
    # skip
    sales_engine = SalesEngine.from_csv({
      :invoices => './data/invoices.csv',
      :invoice_items => './data/invoice_items.csv',
      :transactions => './data/transactions.csv'
    })
    analyst = SalesAnalyst.new(sales_engine)
    date = Time.parse('2009-02-07')
    assert analyst
    assert_equal 21_067.77, analyst.total_revenue_by_date(date)
  end

  def test_it_returns_the_top_X_merchants_based_on_revenue
    # skip
    sales_engine = SalesEngine.from_csv({
      :invoices => './data/invoices.csv',
      :invoice_items => './data/invoice_items.csv',
      :transactions => './data/transactions.csv',
      :merchants => './data/merchants.csv'
    })
    analyst = SalesAnalyst.new(sales_engine)
    number_of_merchants = 20
    results = analyst.top_revenue_earners(number_of_merchants)
    assert_instance_of Merchant, results.first
    assert_equal number_of_merchants, results.count
    last_merchant = results.last
    not_last_merchant = results[0..-2].sample
    assert analyst.revenue_by_merchant(last_merchant.id) < analyst.revenue_by_merchant(not_last_merchant.id)
  end

  def test_it_returns_the_top_20_merchants_based_on_revenue_when_no_argument_given
    # skip
    sales_engine = SalesEngine.from_csv({
      :invoices => './data/invoices.csv',
      :invoice_items => './data/invoice_items.csv',
      :transactions => './data/transactions.csv',
      :merchants => './data/merchants.csv'
    })
    analyst = SalesAnalyst.new(sales_engine)
    results = analyst.top_revenue_earners
    assert_instance_of Merchant, results.first
    assert_equal 20, results.count
  end

  def test_it_returns_all_merchants_with_invoices_which_are_pending
    sales_engine = SalesEngine.from_csv({
      :invoices => './data/invoices.csv',
      :merchants => './data/merchants.csv',
      :transactions => './data/transactions.csv'
    })
    analyst = SalesAnalyst.new(sales_engine)
    results = analyst.merchants_with_pending_invoices
    assert_equal 467, results.count
    assert_instance_of Merchant, results.first
  end
end
