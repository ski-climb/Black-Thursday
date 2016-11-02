require 'minitest/autorun'
require 'minitest/pride'
require './lib/invoice_item'

class InvoiceItemTest < Minitest::Test

  def setup
    @invoice_item_id = 6
    @invoice_item_item_id = 7
    @invoice_item_invoice_id = 8
    @invoice_item_quantity = 1
    @invoice_item_unit_price = 7500
    @invoice_item_created_at = '2013-03-27 14:54:09 UTC'
    @invoice_item_updated_at = '2012-02-26 20:56:56 UTC'
    @invoice_item = InvoiceItem.new({
      :id => @invoice_item_id,
      :item_id => @invoice_item_item_id,
      :invoice_id => @invoice_item_invoice_id,
      :quantity => @invoice_item_quantity,
      :unit_price => @invoice_item_unit_price,
      :created_at => @invoice_item_created_at,
      :updated_at => @invoice_item_updated_at
    })
  end

  def test_invoice_item_has_an_id
    assert_equal @invoice_item_id.to_s, @invoice_item.id
  end

  def test_invoice_item_has_an_item_id
    assert_equal @invoice_item_item_id.to_s, @invoice_item.item_id
  end

  def test_invoice_item_has_an_invoice_id
    assert_equal @invoice_item_invoice_id.to_s, @invoice_item.invoice_id
  end

  def test_invoice_item_has_a_quantity
    assert_equal @invoice_item_quantity, @invoice_item.quantity
  end

  def test_it_has_a_created_at
    created_at = Time.gm(2013, 3, 27, 14, 54, 9)
    assert_equal created_at, @invoice_item.created_at
  end

  def test_it_has_a_updated_at
    updated_at = Time.gm(2012, 2, 26, 20, 56, 56)
    assert_equal updated_at, @invoice_item.updated_at
  end

  def test_it_has_a_unit_price
    assert_equal 7500, @invoice_item.unit_price
  end

  def test_unit_price_is_a_big_decimal
    assert_instance_of BigDecimal, @invoice_item.unit_price
  end

  def test_it_has_a_unit_price_to_dollars
    assert_equal 75.0, @invoice_item.unit_price_to_dollars
  end

  def test_unit_price_to_dollars_is_a_float
    assert_instance_of Float, @invoice_item.unit_price_to_dollars
  end
end
