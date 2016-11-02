require 'minitest/autorun'
require 'minitest/pride'
require './lib/item_repository'
require './lib/item'

class ItemRepositoryTest < Minitest::Test

  def setup
    @item_repository = ItemRepository.new
    @item_1 = Item.new(
      :id => 1,
      :name => "King Soopers",
      :description => "Some place to get food",
      :merchant_id => 1001,
      :unit_price => 1200,
      :created_at => '2013-03-27 14:54:09 UTC',
      :updated_at => '2011-02-22 15:24:19 UTC'
    )
    @item_2 = Item.new(
      :id => 2,
      :name => "Whole Foods",
      :description => "Or is it Whole Paycheck",
      :merchant_id => 1002,
      :unit_price => 1200,
      :created_at => '2013-03-27 14:54:09 UTC',
      :updated_at => '2011-02-22 15:24:19 UTC'
    )
    @item_3 = Item.new(
      :id => 3,
      :name => "Subway",
      :description => "Eat Fresh",
      :merchant_id => 1003,
      :unit_price => 3600,
      :created_at => '2013-03-27 14:54:09 UTC',
      :updated_at => '2011-02-22 15:24:19 UTC'
    )
    @item_repository << @item_1
    @item_repository << @item_2
    @item_repository << @item_3
  end

  def test_it_exists
    assert ItemRepository.new
  end

  def test_it_has_no_items_when_initialized
    item_repository = ItemRepository.new
    assert_equal [], item_repository.all
  end

  def test_items_can_be_added_to_the_repository
    assert_equal 3, @item_repository.all.count
    assert @item_repository.all.map(&:name).include?("King Soopers")
    assert @item_repository.all.map(&:name).include?("Whole Foods")
    assert @item_repository.all.map(&:name).include?("Subway")
  end

  def test_items_can_be_found_by_id
    assert_equal 2, @item_repository.find_by_id(2).id
  end

  def test_find_by_id_returns_nil_when_no_items_have_given_id
    assert_nil @item_repository.find_by_id(12)
  end

  def test_find_by_name_returns_item_with_given_name
    assert_equal "Whole Foods", @item_repository.find_by_name("Whole Foods").name
  end

  def test_find_by_name_is_case_insensitive
    assert_equal "Whole Foods", @item_repository.find_by_name("whole foods").name
  end

  def test_find_by_name_returns_nil_when_no_items_match_given_name
    assert_nil @item_repository.find_by_name("Pizza Hut")
  end

  def test_find_all_with_description_returns_item_with_given_description_stub
    item_4 = Item.new(
      :id => 4,
      :name => "Domino's Pizza",
      :description => "Another pizza place",
      :merchant_id => 1004,
      :unit_price => 3456,
      :created_at => '2013-03-27 14:54:09 UTC',
      :updated_at => '2011-02-22 15:24:19 UTC'
    )
    item_5 = Item.new(
      :id => 5,
      :name => "Pizza Hut",
      :description => "Something about The Hut and pizza",
      :merchant_id => 1005,
      :unit_price => 2345,
      :created_at => '2013-03-27 14:54:09 UTC',
      :updated_at => '2011-02-22 15:24:19 UTC'
    )
    @item_repository.all << item_4
    @item_repository.all << item_5
    results = @item_repository.find_all_with_description("zza")
    assert results.map(&:name).include?("Domino's Pizza")
    assert results.map(&:name).include?("Pizza Hut")
  end

  def test_find_all_with_description_is_case_insensitive
    item_4 = Item.new(
      :id => 4,
      :name => "Domino's Pizza",
      :description => "Another pizza place",
      :merchant_id => 1004,
      :unit_price => 1234,
      :created_at => '2013-03-27 14:54:09 UTC',
      :updated_at => '2011-02-22 15:24:19 UTC'
    )
    item_5 = Item.new(
      :id => 5,
      :name => "Pizza Hut",
      :description => "Something about The Hut and pizza",
      :merchant_id => 1005,
      :unit_price => 1234,
      :created_at => '2013-03-27 14:54:09 UTC',
      :updated_at => '2011-02-22 15:24:19 UTC'
    )
    @item_repository.all << item_4
    @item_repository.all << item_5
    results = @item_repository.find_all_with_description("PIZZA")
    assert results.map(&:name).include?("Domino's Pizza")
    assert results.map(&:name).include?("Pizza Hut")
  end

  def test_find_all_with_description_returns_nil_when_no_items_match_given_description_stub
    assert_equal [], @item_repository.find_all_with_description("Pizza")
  end

  def test_find_all_with_description_can_return_one_match
    assert_equal ["Whole Foods"], @item_repository.find_all_with_description("paycheck").map(&:name)
  end

  def test_an_item_can_be_found_by_merchant_id
    assert_equal [1002], @item_repository.find_all_by_merchant_id(1002).map(&:merchant_id)
  end

  def test_find_all_by_mechant_id_returns_all_items_with_that_merchant_id
    item_5 = Item.new(
      :id => 5,
      :name => "Pizza Hut",
      :description => "Something about The Hut and pizza",
      :merchant_id => 1002,
      :unit_price => 1234,
      :created_at => '2013-03-27 14:54:09 UTC',
      :updated_at => '2011-02-22 15:24:19 UTC'
    )
    @item_repository << item_5
    results = @item_repository.find_all_by_merchant_id(1002)
    assert results.map(&:name).include?("Whole Foods")
    assert results.map(&:name).include?("Pizza Hut")
  end

  def test_find_all_by_merchant_id_returns_nil_when_no_items_have_given_merchant_id
    assert_equal [], @item_repository.find_all_by_merchant_id(12)
  end

  def test_find_all_by_price_returns_an_empty_array_when_no_items_match_price
    assert_equal [], @item_repository.find_all_by_price(1_000)
  end

  def test_find_all_by_price_returns_all_items_which_match_the_price
    results = @item_repository.find_all_by_price(12)
    assert results.map(&:name).include?("King Soopers")
    assert results.map(&:name).include?("Whole Foods")
  end

  def test_find_all_by_price_in_range_returns_all_items_with_prices_in_range
    item_4 = Item.new(
      :id => 4,
      :name => "Pizza Hut",
      :description => "Something about The Hut and pizza",
      :merchant_id => 1002,
      :unit_price => 1234,
      :created_at => '2013-03-27 14:44:09 UTC',
      :updated_at => '2011-02-22 14:24:19 UTC'
    )
    @item_repository << item_4
    results = @item_repository.find_all_by_price_in_range(12..13)
    assert results.map(&:name).include?("King Soopers")
    assert results.map(&:name).include?("Whole Foods")
    assert results.map(&:name).include?("Pizza Hut")
    refute results.map(&:name).include?("Subway")
  end
end
