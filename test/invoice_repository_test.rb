require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/invoice_repository'
require_relative '../lib/invoice'

class InvoiceRepositoryTest < Minitest::Test

  def setup
    @invoice_repository = InvoiceRepository.new
    @invoice_1 = Invoice.new({
      :id          => 1234,
      :customer_id => 2345,
      :merchant_id => 3456,
      :status      => "shipped",
      :created_at  => '2009-02-07',
      :updated_at  => '2015-03-13'
    })
    @invoice_2 = Invoice.new({
      :id          => 987,
      :customer_id => 2345,
      :merchant_id => 3456,
      :status      => "shipped",
      :created_at  => '2009-02-07',
      :updated_at  => '2015-03-13'
    })
    @invoice_3 = Invoice.new({
      :id          => 8383,
      :customer_id => 5432,
      :merchant_id => 6543,
      :status      => "pending",
      :created_at  => '2009-02-07',
      :updated_at  => '2015-03-13'
    })
    @invoice_repository << @invoice_1
    @invoice_repository << @invoice_2
    @invoice_repository << @invoice_3
  end

  def test_it_exists
    assert InvoiceRepository.new
  end

  def test_it_has_no_invoices_when_initialized
    invoice_repository = InvoiceRepository.new
    assert_equal [], invoice_repository.all
  end

  def test_invoices_can_be_added_to_the_repository
    assert_equal 3, @invoice_repository.all.count
    assert @invoice_repository.all.map(&:id).include?(1234)
    assert @invoice_repository.all.map(&:id).include?(987)
    assert @invoice_repository.all.map(&:id).include?(8383)
  end

  def test_find_by_id_returns_nil_when_no_invoice_matches_id
    assert_nil @invoice_repository.find_by_id(99)
  end

  def test_invoices_can_be_found_by_id
    invoice_id = '1234'
    assert_equal invoice_id.to_i, @invoice_repository.find_by_id(invoice_id).id
  end

  def test_it_returns_empty_array_when_no_customer_ids_match
    assert_equal  [], @invoice_repository.find_all_by_customer_id(99)
  end

  def test_it_finds_all_by_customer_id
    customer_id = '2345'
    results = @invoice_repository.find_all_by_customer_id(customer_id)
    assert_equal 2, results.count
    assert_equal customer_id.to_i, results.map(&:customer_id).uniq.first
  end

  def test_it_returns_empty_array_when_no_merchant_ids_match
    assert_equal [], @invoice_repository.find_all_by_merchant_id(99)
  end

  def test_it_finds_all_by_merchant_id
    merchant_id = '3456'
    results = @invoice_repository.find_all_by_merchant_id(merchant_id)
    assert_equal 2, results.count
    assert_equal merchant_id.to_i, results.map(&:merchant_id).uniq.first
  end

  def test_it_returns_empty_array_when_no_status_matches
    assert_equal [], @invoice_repository.find_all_by_status("giggling")
  end

  def test_it_finds_all_by_status
    status = "shipped"
    results = @invoice_repository.find_all_by_status(status)
    assert_equal 2, results.count
    assert_equal status, results.map(&:status).uniq.first
  end
end
