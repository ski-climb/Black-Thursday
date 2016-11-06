require 'bigdecimal'
require_relative './test_helper.rb'
require_relative '../lib/invoice_item_repository'
require_relative '../lib/invoice_item'

class InvoiceItemRepositoryTest < Minitest::Test

  def setup
    @sales_engine = Minitest::Mock.new
    @invoice_item_repository = InvoiceItemRepository.new(@sales_engine)
    invoice_item_1 = InvoiceItem.new({
      :id => 1234,
      :item_id => 234,
      :invoice_id => 12,
      :quantity => 2,
      :unit_price => 1200,
      :created_at => '2012-03-27 14:54:09 UTC',
      :updated_at => '2012-03-27 14:54:09 UTC'
    }, @sales_engine)
    invoice_item_2 = InvoiceItem.new({
      :id => 2345,
      :item_id => 234,
      :invoice_id => 23,
      :quantity => 2,
      :unit_price => 2000,
      :created_at => '2012-03-27 14:54:09 UTC',
      :updated_at => '2012-03-27 14:54:09 UTC'
    }, @sales_engine)
    invoice_item_3 = InvoiceItem.new({
      :id => 3456,
      :item_id => 123,
      :invoice_id => 23,
      :quantity => 4,
      :unit_price => 1800,
      :created_at => '2012-03-27 14:54:09 UTC',
      :updated_at => '2012-03-27 14:54:09 UTC'
    }, @sales_engine)
    @invoice_item_repository << invoice_item_1
    @invoice_item_repository << invoice_item_2
    @invoice_item_repository << invoice_item_3
  end

  def test_it_has_no_invoice_items_when_initialized
    invoice_item_repository = InvoiceItemRepository.new(@sales_engine)
    assert_equal [], invoice_item_repository.all
  end

  def test_invoice_items_can_be_added_to_the_repository
    assert_equal 3, @invoice_item_repository.all.count
    assert @invoice_item_repository.all.map(&:id).include?(1234)
    assert @invoice_item_repository.all.map(&:id).include?(2345)
    assert @invoice_item_repository.all.map(&:id).include?(3456)
  end

  def test_it_returns_nil_when_no_invoice_items_have_given_id
    assert_nil @invoice_item_repository.find_by_id(1_000_000)
  end

  def test_it_returns_an_empty_array_when_no_invoice_items_have_given_item_id
    assert_equal [], @invoice_item_repository.find_all_by_item_id(1_000_000)
  end

  def test_it_returns_an_empty_array_when_no_invoice_items_have_given_invoice_id
    assert_equal [], @invoice_item_repository.find_all_by_invoice_id(1_000_000)
  end

  def test_invoice_items_can_be_found_by_id
    assert_equal 1234, @invoice_item_repository.find_by_id(1234).id
  end

  def test_invoice_items_can_all_be_found_by_item_id
    item_id = 234
    results = @invoice_item_repository.find_all_by_item_id(item_id)
    assert_equal 2, results.count
    assert_equal item_id, results.map(&:item_id).uniq.first
  end

  def test_invoice_items_can_all_be_found_by_invoice_id
    invoice_id = 23
    results = @invoice_item_repository.find_all_by_invoice_id(invoice_id)
    assert_equal 2, results.count
    assert_equal invoice_id, results.map(&:invoice_id).uniq.first
  end
end


