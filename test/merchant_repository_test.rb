require_relative './test_helper.rb'
require_relative '../lib/merchant_repository'
require_relative '../lib/merchant'

class MerchantRepositoryTest < Minitest::Test

  def setup
    @merchant_repository = MerchantRepository.new
    merchant_1 = Merchant.new(:id => 1, :name => "King Soopers")
    merchant_2 = Merchant.new(:id => 2, :name => "Whole Foods")
    merchant_3 = Merchant.new(:id => 3, :name => "Subway")
    @merchant_repository << merchant_1
    @merchant_repository << merchant_2
    @merchant_repository << merchant_3
  end

  def test_it_exists
    assert MerchantRepository.new
  end

  def test_it_has_no_merchants_when_initialized
    merchant_repository = MerchantRepository.new
    assert_equal [], merchant_repository.all
  end

  def test_merchants_can_be_added_to_the_repository
    assert_equal 3, @merchant_repository.all.count
    assert @merchant_repository.all.map(&:name).include?("King Soopers")
    assert @merchant_repository.all.map(&:name).include?("Whole Foods")
    assert @merchant_repository.all.map(&:name).include?("Subway")
  end

  def test_merchants_can_be_found_by_id
    assert_equal 2, @merchant_repository.find_by_id(2).id
  end

  def test_find_by_id_returns_nil_when_no_merchants_have_given_id
    assert_nil @merchant_repository.find_by_id(12)
  end

  def test_find_by_name_returns_merchant_with_given_name
    assert_equal "Whole Foods", @merchant_repository.find_by_name("Whole Foods").name
  end

  def test_find_by_name_is_case_insensitive
    assert_equal "Whole Foods", @merchant_repository.find_by_name("whole foods").name
  end

  def test_find_by_name_returns_nil_when_no_merchants_match_given_name
    assert_nil @merchant_repository.find_by_name("Pizza Hut")
  end

  def test_find_all_by_name_returns_merchant_with_given_name_stub
    merchant_4 = Merchant.new(:id => 4, :name => "Domino's Pizza")
    merchant_5 = Merchant.new(:id => 5, :name => "Pizza Hut")
    @merchant_repository.all << merchant_4
    @merchant_repository.all << merchant_5
    results = @merchant_repository.find_all_by_name("zza")
    assert results.map(&:name).include?("Domino's Pizza")
    assert results.map(&:name).include?("Pizza Hut")
  end

  def test_find_all_by_name_is_case_insensitive
    merchant_4 = Merchant.new(:id => 4, :name => "Domino's Pizza")
    merchant_5 = Merchant.new(:id => 5, :name => "Pizza Hut")
    @merchant_repository.all << merchant_4
    @merchant_repository.all << merchant_5
    results = @merchant_repository.find_all_by_name("PIZZA")
    assert results.map(&:name).include?("Domino's Pizza")
    assert results.map(&:name).include?("Pizza Hut")
  end

  def test_find_all_by_name_returns_nil_when_no_merchants_match_given_name_stub
    assert_equal [], @merchant_repository.find_all_by_name("Pizza")
  end

  def test_find_all_by_name_can_return_one_match
    assert_equal ["Whole Foods"], @merchant_repository.find_all_by_name("Whole Foods").map(&:name)
  end
end
