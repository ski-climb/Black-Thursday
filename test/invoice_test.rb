require_relative './test_helper.rb'
require_relative '../lib/invoice'
require_relative '../lib/sales_engine'

class InvoiceTest < Minitest::Test

  def setup
    invoice_id = 6
    invoice_customer_id = 7
    invoice_merchant_id = 8
    invoice_status = "pending"
    invoice_created_at = '2013-03-27'
    invoice_updated_at = '2012-02-26'
    sales_engine = SalesEngine
    @invoice = Invoice.new({
      :id => invoice_id,
      :customer_id => invoice_customer_id,
      :merchant_id => invoice_merchant_id,
      :status => invoice_status,
      :created_at => invoice_created_at,
      :updated_at => invoice_updated_at
    }, sales_engine)
  end

  def test_invoice_has_an_id
    assert_equal 6, @invoice.id
  end

  def test_invoice_has_a_customer_id
    assert_equal 7, @invoice.customer_id
  end

  def test_invoice_has_a_merchant_id
    assert_equal 8, @invoice.merchant_id
  end

  def test_invoice_has_a_status
    assert_equal :pending, @invoice.status
  end

  def test_it_has_a_created_at
    created_at = Time.parse('2013-03-27')
    assert_equal created_at, @invoice.created_at
  end

  def test_it_has_a_updated_at
    updated_at = Time.parse('2012-02-26')
    assert_equal updated_at, @invoice.updated_at
  end

  def test_invoice_responds_to_merchant
    assert_respond_to @invoice, :merchant
  end
end
