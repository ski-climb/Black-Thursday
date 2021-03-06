require 'bigdecimal'
require_relative './test_helper.rb'
require_relative '../lib/sales_engine'
require_relative '../lib/sales_analyst'
require_relative '../lib/merchant_repository'

class InvoiceAnalyzerTest < Minitest::Test

  def test_it_can_import_the_provided_file_for_invoices
    sales_engine = SalesEngine.from_csv({
      :invoices => './data/invoices.csv'
    })
    results = sales_engine.invoices
    assert_equal 4985, results.all.count
    assert results.find_by_id(6)
    assert results.find_by_id(4977)
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

  def test_an_invoice_can_find_its_customer
    sales_engine = SalesEngine.from_csv({
      :customers => './test/fixtures/customer_fixture.csv',
      :invoices => './test/fixtures/invoice_fixture.csv'
    })
    customer_id = 12341234
    customer = sales_engine.customers.find_by_id(customer_id)
    invoice = sales_engine.invoices.find_all_by_customer_id(customer_id).first
    assert invoice.customer
    assert_equal customer, invoice.customer
  end

  def test_an_invoice_can_find_its_transactions
    sales_engine = SalesEngine.from_csv({
      :transactions => './test/fixtures/transaction_fixture.csv',
      :invoices => './test/fixtures/invoice_fixture.csv'
    })
    invoice_id = 12341234
    invoice = sales_engine.invoices.find_by_id(invoice_id)
    transactions = sales_engine.transactions.find_all_by_invoice_id(invoice_id)
    assert_equal transactions, invoice.transactions
    assert_equal 3, transactions.count
  end

  def test_it_calculates_top_days_by_invoice_count
    sales_engine = SalesEngine.from_csv({
      :invoices => './data/invoices.csv'
    })
    analyst = SalesAnalyst.new(sales_engine)
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
