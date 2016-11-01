require 'minitest/autorun'
require 'minitest/pride'
require './lib/merchant_repository'
require './lib/merchant'

class MerchantRepositoryTest < Minitest::Test

  def test_it_exists
    assert MerchantRepository.new
  end

  def test_it_has_no_merchants_when_initialized
    assert_equal [], mr.all
  end

  def test_it_has_merchants
    mr = MerchantRepository.new
    merchant_1 = Merchant.new(1, "King Soopers")
    merchant_2 = Merchant.new(2, "Whole Foods")
    merchant_3 = Merchant.new(3, "Subway")
    mr.all << merchant_1
    mr.all << merchant_2
    mr.all << merchant_3
    assert_same_elements mr.all, [merchant_1, merchant_2, merchant_3]
  end

  def test_merchants_can_be_found_by_id
    mr = MerchantRepository.new
    merchant_1 = Merchant.new(1, "King Soopers")
    merchant_2 = Merchant.new(2, "Whole Foods")
    merchant_3 = Merchant.new(3, "Subway")
    mr.all << merchant_1
    mr.all << merchant_2
    mr.all << merchant_3
    assert_equal mr.find_by_id(2), merchant_2
  end

  def test_find_by_id_returns_nil_when_no_merchants_have_given_id
    mr = MerchantRepository.new
    merchant_1 = Merchant.new(1, "King Soopers")
    merchant_2 = Merchant.new(2, "Whole Foods")
    merchant_3 = Merchant.new(3, "Subway")
    mr.all << merchant_1
    mr.all << merchant_2
    mr.all << merchant_3
    assert_nil mr.find_by_id(12)
  end

  def test_find_by_name_returns_merchant_with_given_name
    mr = MerchantRepository.new
    merchant_1 = Merchant.new(1, "King Soopers")
    merchant_2 = Merchant.new(2, "Whole Foods")
    merchant_3 = Merchant.new(3, "Subway")
    mr.all << merchant_1
    mr.all << merchant_2
    mr.all << merchant_3
    assert_equal mr.find_by_name("Whole Foods"), merchant_2
  end

  def test_find_by_name_returns_nil_when_no_merchants_match_given_name
    mr = MerchantRepository.new
    merchant_1 = Merchant.new(1, "King Soopers")
    merchant_2 = Merchant.new(2, "Whole Foods")
    merchant_3 = Merchant.new(3, "Subway")
    mr.all << merchant_1
    mr.all << merchant_2
    mr.all << merchant_3
    assert_nil mr.find_by_name("Pizza Hut")
  end

  def test_find_all_by_name_returns_merchant_with_given_name_stub
    mr = MerchantRepository.new
    merchant_1 = Merchant.new(1, "King Soopers")
    merchant_2 = Merchant.new(2, "Whole Foods")
    merchant_3 = Merchant.new(3, "Subway")
    merchant_4 = Merchant.new(4, "Dominoe's Pizza")
    merchant_5 = Merchant.new(5, "Pizza Hut")
    mr.all << merchant_1
    mr.all << merchant_2
    mr.all << merchant_3
    mr.all << merchant_4
    mr.all << merchant_5
    assert_same_elements mr.find_all_by_name("Pizza"), [merchant_4, merchant_5]
  end

  def test_find_all_by_name_returns_nil_when_no_merchants_match_given_name_stub
    mr = MerchantRepository.new
    merchant_1 = Merchant.new(1, "King Soopers")
    merchant_2 = Merchant.new(2, "Whole Foods")
    merchant_3 = Merchant.new(3, "Subway")
    mr.all << merchant_1
    mr.all << merchant_2
    mr.all << merchant_3
    assert_nil mr.find_all_by_name("Pizza")
  end
end
