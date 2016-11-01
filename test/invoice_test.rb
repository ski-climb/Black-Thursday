require 'minitest/autorun'
require 'minitest/pride'
require './lib/invoice'

class InvoiceTest < Minitest::Test

  def setup
    @invoice_id = 6
    @invoice_customer_id = 7
    @invoice_merchant_id = 8
    @invoice_status = "pending"
    @invoice = Invoice.new({
      :id => @invoice_id,
      :customer_id => @invoice_customer_id,
      :merchant_id => @invoice_merchant_id,
      :status => @invoice_status
    })
  end

  def test_invoice_has_an_id
    assert_equal @invoice_id, @invoice.id
  end

  def test_invoice_has_a_customer_id
    assert_equal @invoice_customer_id, @invoice.customer_id
  end

  def test_invoice_has_a_merchant_id
    assert_equal @invoice_merchant_id, @invoice.merchant_id
  end

  def test_invoice_has_a_status
    assert_equal @invoice_status, @invoice.status
  end

end