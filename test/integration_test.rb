require 'bigdecimal'
require_relative './test_helper.rb'
require_relative '../lib/sales_engine'
require_relative '../lib/sales_analyst'
require_relative '../lib/merchant_repository'
require_relative '../lib/item_repository'

class IntegrationTest < Minitest::Test

  def test_an_invoice_can_list_all_items_for_that_invoice
    sales_engine = SalesEngine.from_csv({
      :invoices => './data/invoices.csv',
      :invoice_items => './data/invoice_items.csv',
      :items => './data/items.csv',
    })
    invoice_id = 1
    invoice = sales_engine.invoices.find_by_id(invoice_id)
    assert invoice.items
    assert_instance_of Item, invoice.items.first
    assert_equal 8, invoice.items.length
  end

  def test_a_transaction_can_find_its_invoice
    sales_engine = SalesEngine.from_csv({
      :transactions => './data/transactions.csv',
      :invoices => './data/invoices.csv'
    })
    transaction = sales_engine.transactions.find_by_id(1)
    assert transaction
    assert transaction.invoice
    assert_instance_of Invoice, transaction.invoice
  end

  def test_it_finds_all_customers_for_given_merchant
    sales_engine = SalesEngine.from_csv({
      :customers => './data/customers.csv',
      :merchants => './data/merchants.csv',
      :invoices => './data/invoices.csv'
    })
    merchant = sales_engine.merchants.find_by_id(12334194)
    assert merchant
    assert merchant.customers
    assert_instance_of Customer, merchant.customers.first
    assert_equal 12, merchant.customers.count
  end

  def test_it_finds_all_merchants_for_a_given_customer
    sales_engine = SalesEngine.from_csv({
      :customers => './data/customers.csv',
      :merchants => './data/merchants.csv',
      :invoices => './data/invoices.csv'
    })
    customer = sales_engine.customers.find_by_id(1)
    assert customer
    assert customer.merchants
    assert_instance_of Merchant, customer.merchants.first
    assert_equal 8, customer.merchants.count
  end

  def test_it_returns_that_an_invoice_has_been_paid_in_full
    sales_engine = SalesEngine.from_csv({
      :transactions => './data/transactions.csv',
      :invoices => './data/invoices.csv'
    })
    invoice = sales_engine.invoices.find_by_id(1)
    assert invoice
    assert invoice.is_paid_in_full?
  end
end
