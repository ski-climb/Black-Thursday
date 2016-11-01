require 'minitest/autorun'
require 'minitest/pride'
require './lib/importer'
require './lib/merchant_repository'

class ImporterTest < Minitest::Test

  def test_it_exists
    path_and_filename = './test/fixtures/empty_merchant_fixture'
    repository = MerchantRepository.new
    assert Importer.new(path_and_filename, repository)
  end

  def test_it_returns_an_empty_array_if_the_file_is_empty
    merchant_repository = MerchantRepository.new
    path_and_filename = './test/fixtures/empty_merchant_fixture.csv'
    number_of_merchants_in_file = 0
    importer = Importer.new(path_and_filename, merchant_repository)
    importer.import_merchants
    assert_equal 0, merchant_repository.all.length
  end

  def test_it_imports_merchants
    merchant_repository = MerchantRepository.new
    number_of_merchants_in_file = 32
    path_and_filename = './test/fixtures/merchant_fixture.csv'
    importer = Importer.new(path_and_filename, merchant_repository)
    importer.import_merchants
    assert_equal number_of_merchants_in_file, merchant_repository.all.length
  end
end

