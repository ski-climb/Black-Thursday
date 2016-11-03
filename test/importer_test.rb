require_relative './test_helper.rb'
require_relative '../lib/importer'
require_relative '../lib/merchant_repository'
require_relative '../lib/item_repository'

class ImporterTest < Minitest::Test

  def test_it_exists
    assert Importer.read_file('./test/fixtures/empty_merchant_fixture.csv')
  end

  def test_it_takes_a_filename_for_a_csv
    path_and_filename = './test/fixtures/empty_merchant_fixture.csv'
    importer = Importer.read_file(path_and_filename)
    assert_instance_of CSV, importer
  end
end

