require_relative './test_helper.rb'
require_relative '../lib/importer'
require_relative '../lib/merchant_repository'
require_relative '../lib/item_repository'

class ImporterTest < Minitest::Test

  def test_it_exists
    path_and_filename = './test/fixtures/empty_merchant_fixture'
    repository = MerchantRepository.new
    sales_engine = SalesEngine
    assert Importer.new(path_and_filename, repository, sales_engine)
  end

  def test_it_returns_an_empty_array_if_the_file_is_empty
    merchant_repository = MerchantRepository.new
    path_and_filename = './test/fixtures/empty_merchant_fixture.csv'
    sales_engine = SalesEngine
    importer = Importer.new(path_and_filename, merchant_repository, sales_engine)
    importer.import_merchants
    assert_equal 0, merchant_repository.all.length
  end

  def test_it_imports_merchants
    merchant_repository = MerchantRepository.new
    number_of_merchants = 32
    path_and_filename = './test/fixtures/merchant_fixture.csv'
    sales_engine = SalesEngine
    importer = Importer.new(path_and_filename, merchant_repository, sales_engine)
    importer.import_merchants
    assert_equal number_of_merchants, merchant_repository.all.length
    assert merchant_repository.all.map(&:name).include?("VectorCoast")
  end

  def test_it_imports_items
    item_repository = ItemRepository.new
    number_of_items = 12
    path_and_filename = './test/fixtures/item_fixture.csv'
    sales_engine = SalesEngine
    importer = Importer.new(path_and_filename, item_repository, sales_engine)
    importer.import_items
    assert_equal number_of_items, item_repository.all.length
    assert item_repository.all.map(&:name).include?("Anello nodo")
  end

  def test_it_imports_invoices
    invoice_repository = InvoiceRepository.new
    number_of_invoices = 99
    path_and_filename = './test/fixtures/invoice_fixture.csv'
    sales_engine = SalesEngine
    importer = Importer.new(path_and_filename, invoice_repository, sales_engine)
    importer.import_invoices
    assert_equal number_of_invoices, invoice_repository.all.length
    assert invoice_repository.find_by_id(40)
  end
end

