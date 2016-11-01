require 'minitest/autorun'
require 'minitest/pride'
require './lib/item'

class ItemTest < Minitest::Test

  def setup
    @item_id = 12345678
    @item_name = "DesignerEstore"
    @item_description = "Disney glitter frames"
    @item_merchant_id = 12334141
    @item = Item.new(@item_id, @item_name, @item_description, @item_merchant_id)
  end

  def test_it_has_an_id
    assert_equal @item_id, @item.id
  end

  def test_it_has_a_name
    assert_equal @item_name, @item.name
  end

  def test_it_has_a_description
    assert_equal @item_description, @item.description
  end

  def test_it_has_a_merchant_id
    assert_equal @item_merchant_id, @item.merchant_id
  end

end