require 'minitest/autorun'
require 'minitest/pride'
require './lib/invoice_item'

class InvoiceItemTest < Minitest::Test

  def setup
    @invoice_item_id = 6
    @invoice_item_item_id = 7
    @invoice_item_invoice_id = 8
    @invoice_item_quantity = 1
    @invoice_item = InvoiceItem.new({
      :id => @invoice_item_id,
      :item_id => @invoice_item_item_id,
      :invoice_id => @invoice_item_invoice_id,
      :quantity => @invoice_item_quantity
    })
  end

  def test_it_has_an_id
    assert_equal @invoice_item_id, @invoice_item.id
  end

  def test_it_has_an_item_id
    assert_equal @invoice_item_item_id, @invoice_item.item_id
  end

  def test_it_has_an_invoice_id
    assert_equal @invoice_item_invoice_id, @invoice_item.invoice_id
  end

  def test_it_has_a_quantity
    assert_equal @invoice_item_quantity, @invoice_item.quantity
  end

end