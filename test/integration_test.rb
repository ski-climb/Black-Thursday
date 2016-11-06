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
    assert_equal 8, invoice.items.length
    assert_instance_of Item, invoice.items.first
  end
end
