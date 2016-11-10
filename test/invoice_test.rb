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
    @sales_engine = Minitest::Mock.new
    @invoice = Invoice.new({
      :id => invoice_id,
      :customer_id => invoice_customer_id,
      :merchant_id => invoice_merchant_id,
      :status => invoice_status,
      :created_at => invoice_created_at,
      :updated_at => invoice_updated_at
    }, @sales_engine)
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

  def test_it_points_to_sales_engine
    assert @invoice.sales_engine
  end

  def test_it_has_a_created_at
    created_at = Time.parse('2013-03-27')
    assert_equal created_at, @invoice.created_at
  end

  def test_it_has_a_updated_at
    updated_at = Time.parse('2012-02-26')
    assert_equal updated_at, @invoice.updated_at
  end

  def test_it_responds_to_merchant
    assert_respond_to @invoice, :merchant
  end

  def test_it_has_a_merchant
    merchant = Minitest::Mock.new
    @sales_engine.expect(:find_merchant_by_id, [merchant], [8])
    @invoice.merchant
    @sales_engine.verify
  end

  def test_it_responds_to_transactions
    assert_respond_to @invoice, :transactions
  end

  def test_it_has_transactions
    transaction = Minitest::Mock.new
    @sales_engine.expect(:find_transactions_by_invoice_id, [transaction], [@invoice.id])
    @invoice.transactions
    @sales_engine.verify
  end

  def test_it_responds_to_customer
    assert_respond_to @invoice, :customer
  end

  def test_it_has_a_customer
    customer = Minitest::Mock.new
    @sales_engine.expect(:find_customer_by_id, [customer], [7])
    @invoice.customer
    @sales_engine.verify
  end

  def test_it_responds_to_items
    assert_respond_to @invoice, :items
  end

  def test_it_has_items
    item = Minitest::Mock.new
    @sales_engine.expect(:find_items_by_invoice_id, [item], [@invoice.id])
    @invoice.items
    @sales_engine.verify
  end

  def test_it_responds_to_is_paid_in_full
    assert_respond_to @invoice, :is_paid_in_full?
  end

  def test_it_responds_to_total
    assert_respond_to @invoice, :total
  end

  def test_it_has_a_total
    total = Minitest::Mock.new
    @sales_engine.expect(:successfully_charged_total_for_invoice, [total], [@invoice.id])
    @invoice.total
    @sales_engine.verify
  end
end
