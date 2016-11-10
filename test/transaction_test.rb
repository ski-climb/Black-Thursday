require_relative './test_helper.rb'
require_relative '../lib/transaction'

class TransactionTest < Minitest::Test

  def setup
    transaction_id = 6
    transaction_invoice_id = 8
    transaction_credit_card_number = "4242424242424242"
    transaction_credit_card_expiration_date = "0220"
    transaction_result = "success"
    transaction_created_at = '2013-03-27 14:54:09 UTC'
    transaction_updated_at = '2012-02-26 20:56:56 UTC'
    @sales_engine = Minitest::Mock.new
    @transaction = Transaction.new({
      :id => transaction_id,
      :invoice_id => transaction_invoice_id,
      :credit_card_number => transaction_credit_card_number,
      :credit_card_expiration_date => transaction_credit_card_expiration_date,
      :result => transaction_result,
      :created_at => transaction_created_at,
      :updated_at => transaction_updated_at
    }, @sales_engine)
  end

  def test_transaction_has_an_id
    assert_equal 6, @transaction.id
  end

  def test_transaction_has_an_invoice_id
    assert_equal 8, @transaction.invoice_id
  end

  def test_transaction_has_a_credit_card_number
    assert_equal 4242424242424242, @transaction.credit_card_number
  end

  def test_transaction_has_a_credit_card_expiration_date
    assert_equal "0220", @transaction.credit_card_expiration_date
  end

  def test_transaction_has_a_result
    assert_equal "success", @transaction.result
  end

  def test_it_points_to_sales_engine
    assert @transaction.sales_engine
  end

  def test_it_responds_to_invoice
    assert_respond_to @transaction, :invoice
  end

  def test_it_has_an_invoice
    invoice = Minitest::Mock.new
    @sales_engine.expect(:find_invoice_by_id, [invoice], [8])
    @transaction.invoice
    @sales_engine.verify
  end

  def test_it_has_a_created_at
    created_at = Time.gm(2013, 3, 27, 14, 54, 9)
    assert_equal created_at, @transaction.created_at
  end

  def test_it_has_a_updated_at
    updated_at = Time.gm(2012, 2, 26, 20, 56, 56)
    assert_equal updated_at, @transaction.updated_at
  end
end
