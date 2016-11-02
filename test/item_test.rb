require 'minitest/autorun'
require 'minitest/pride'
require './lib/item'

class ItemTest < Minitest::Test

  def setup
    item_id = 12345678
    item_name = "DesignerEstore"
    item_description = "Disney glitter frames"
    item_merchant_id = 12334141
    item_unit_price = 7500
    item_created_at = '2013-03-27 14:54:09 UTC'
    item_updated_at = '2012-02-26 20:56:56 UTC'
    sales_engine = SalesEngine
    @item = Item.new({
      :id => item_id,
      :name => item_name,
      :description => item_description,
      :merchant_id => item_merchant_id,
      :unit_price => item_unit_price,
      :created_at => item_created_at,
      :updated_at => item_updated_at,
      :sales_engine => sales_engine
    })
  end

  def test_it_has_an_id
    assert_equal '12345678', @item.id
  end

  def test_it_has_a_name
    assert_equal "DesignerEstore", @item.name
  end

  def test_it_has_a_description
    assert_equal "Disney glitter frames", @item.description
  end

  def test_it_has_a_merchant_id
    assert_equal "12334141", @item.merchant_id
  end

  def test_it_has_a_unit_price
    assert_equal 7500, @item.unit_price
  end

  def test_unit_price_is_a_big_decimal
    assert_instance_of BigDecimal, @item.unit_price
  end

  def test_it_has_a_created_at
    created_at = Time.gm(2013, 3, 27, 14, 54, 9)
    assert_equal created_at, @item.created_at
  end

  def test_it_has_a_updated_at
    updated_at = Time.gm(2012, 2, 26, 20, 56, 56)
    assert_equal updated_at, @item.updated_at
  end

  def test_it_has_a_unit_price_to_dollars
    assert_equal 75.0, @item.unit_price_to_dollars
  end

  def test_unit_price_to_dollars_is_a_float
    assert_instance_of Float, @item.unit_price_to_dollars
  end

  def test_items_point_to_sales_engine
    assert_kind_of Class, @item.sales_engine
  end

  def test_items_respond_to_merchant_method
    assert_respond_to @item, :merchant
  end
end
