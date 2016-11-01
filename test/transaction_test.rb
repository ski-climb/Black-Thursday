require 'minitest/autorun'
require 'minitest/pride'
require './lib/transaction'

class TransactionTest < Minitest::Test

  def setup
    @transaction_id = 6
    @transaction_invoice_id = 8
    @transaction_credit_card_number = "4242424242424242"
    @transaction_credit_card_expiration_date = "0220"
    @transaction_result = "success"
    @transaction = Transaction.new({
      :id => @transaction_id,
      :invoice_id => @transaction_invoice_id,
      :credit_card_number => @transaction_credit_card_number,
      :credit_card_expiration_date => @transaction_credit_card_expiration_date,
      :result => @transaction_result
    })
  end

  def test_transaction_has_an_id
    assert_equal @transaction_id, @transaction.id
  end

  def test_transaction_has_an_invoice_id
    assert_equal @transaction_invoice_id, @transaction.invoice_id
  end

  def test_transaction_has_a_credit_card_number
    assert_equal @transaction_credit_card_number, @transaction.credit_card_number
  end

  def test_transaction_has_a_credit_card_expiration_date
    assert_equal @transaction_credit_card_expiration_date, @transaction.credit_card_expiration_date
  end

  def test_transaction_has_a_result
    assert_equal @transaction_result, @transaction.result
  end

end