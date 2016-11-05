require 'bigdecimal'
require_relative './test_helper.rb'
require_relative '../lib/sales_engine'
require_relative '../lib/sales_analyst'
require_relative '../lib/merchant_repository'

class InvoiceAnalyzerTest < Minitest::Test

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

  def test_it_can_import_the_provided_file_for_invoices
    # skip "for speed!"
    sales_engine = SalesEngine.from_csv({
      :invoices => './data/invoices.csv'
    })
    results = sales_engine.invoices
    assert_equal 4985, results.all.count
    assert results.find_by_id(6)
    assert results.find_by_id(4977)
  end

  def test_it_calculates_top_days_by_invoice_count
    # skip "for speed!"
    sales_engine = SalesEngine.from_csv({
      :invoices => './data/invoices.csv'
    })
    analyst = SalesAnalyst.new(sales_engine)
    # require 'pry'; binding.pry
    assert_equal ["Wednesday"], analyst.top_days_by_invoice_count
  end

  def test_it_returns_the_percent_of_all_invoices_with_given_status
    sales_engine = SalesEngine.from_csv({
      :invoices => './data/invoices.csv'
    })
    analyst = SalesAnalyst.new(sales_engine)
    assert_equal 29.55, analyst.invoice_status(:pending)
    assert_equal 56.95, analyst.invoice_status(:shipped)
    assert_equal 13.50, analyst.invoice_status(:returned)
  end
end
