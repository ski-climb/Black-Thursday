require 'bigdecimal'
require_relative './test_helper.rb'
require_relative '../lib/transaction_repository'
require_relative '../lib/transaction'

class TransactionRepositoryTest < Minitest::Test

  def setup
    @sales_engine = Minitest::Mock.new
    @transaction_repository = TransactionRepository.new(@sales_engine)
    transaction_1 = Transaction.new({
      :id => 1234,
      :invoice_id => 123,
      :credit_card_number => '4242424242424242',
      :credit_card_expiration_date => '0220',
      :result => "success",
      :created_at => '2012-03-27 14:54:09 UTC',
      :updated_at => '2012-03-27 14:54:09 UTC'
      }, @sales_engine)
    transaction_2 = Transaction.new({
      :id => 123,
      :invoice_id => 123,
      :credit_card_number => '4242424242424241',
      :credit_card_expiration_date => '0220',
      :result => "failed",
      :created_at => '2012-03-27 14:54:09 UTC',
      :updated_at => '2012-03-27 14:54:09 UTC'
      }, @sales_engine)
    transaction_3 = Transaction.new({
      :id => 12,
      :invoice_id => 234,
      :credit_card_number => '4242424242424242',
      :credit_card_expiration_date => '0220',
      :result => "success",
      :created_at => '2012-03-27 14:54:09 UTC',
      :updated_at => '2012-03-27 14:54:09 UTC'
      }, @sales_engine)
    @transaction_repository << transaction_1
    @transaction_repository << transaction_2
    @transaction_repository << transaction_3
  end

  def test_it_exists
    assert @transaction_repository
  end

  def test_it_has_no_transactions_when_initialized
    transaction_repository = TransactionRepository.new(@sales_engine)
    assert_equal [], transaction_repository.all
  end

  def test_transactions_can_be_added_to_the_repository
    assert_equal 3, @transaction_repository.all.count
    assert @transaction_repository.all.map(&:id).include?(1234)
    assert @transaction_repository.all.map(&:id).include?(123)
    assert @transaction_repository.all.map(&:id).include?(12)
  end

  def test_it_returns_nil_when_no_transactions_have_provided_id
    assert_nil @transaction_repository.find_by_id(4321)
  end

  def test_it_returns_an_empty_array_when_no_transactions_have_provided_invoice_id
    assert_equal [], @transaction_repository.find_all_by_invoice_id(1_000_000)
  end

  def test_it_returns_an_empty_array_when_no_transactions_have_provided_credit_card_number
    assert_equal [], @transaction_repository.find_all_by_credit_card_number('24')
  end

  def test_it_returns_an_empty_array_when_no_transactions_have_provided_result
    assert_equal [], @transaction_repository.find_all_by_result("giggling")
  end

  def test_it_can_find_transactions_by_id
    id = 12
    assert_equal id, @transaction_repository.find_by_id(id).id
  end

  def test_it_can_find_all_invoices_with_given_invoice_id
    invoice_id = 123
    results = @transaction_repository.find_all_by_invoice_id(invoice_id)
    assert_equal 2, results.count
    assert_equal invoice_id, results.map(&:invoice_id).uniq.first
  end

  def test_it_can_find_all_transactions_by_given_credit_card_number
    credit_card_number = 4242424242424242
    results = @transaction_repository.find_all_by_credit_card_number(credit_card_number)
    assert_equal 2, results.count
    assert_equal credit_card_number, results.map(&:credit_card_number).uniq.first
  end

  def test_it_can_find_all_transactions_by_given_result
    result = "success"
    results = @transaction_repository.find_all_by_result(result)
    assert_equal 2, results.count
    assert_equal result, results.map(&:result).first
  end
end
