require_relative './test_helper.rb'
require_relative '../lib/sales_engine'
require_relative '../lib/merchant_repository'
require_relative '../lib/item_repository'
require_relative '../lib/transaction_repository'

class SalesEngineTest < Minitest::Test

  def test_it_exists
    assert SalesEngine.new
  end

  def test_it_responds_to_from_csv
    assert SalesEngine.from_csv({})
  end

  def test_from_csv_can_take_a_hash_of_arguments
    assert SalesEngine.from_csv({
      :items =>     './test/fixtures/item_fixture.csv',
      :merchants => './test/fixtures/merchant_fixture.csv',
      :invoices =>  './test/fixtures/invoice_fixture.csv'
    })
  end

  def test_it_returns_a_merchant_repo
    path_and_filename = './test/fixtures/merchant_fixture.csv'
    sales_engine = SalesEngine.from_csv({:merchants => path_and_filename})
    assert_instance_of MerchantRepository, sales_engine.merchants
  end

  def test_it_returns_an_item_repo
    path_and_filename = './test/fixtures/item_fixture.csv'
    sales_engine = SalesEngine.from_csv({:items => path_and_filename})
    assert_instance_of ItemRepository, sales_engine.items
  end

  def test_it_returns_an_invoice_repo
    path_and_filename = './test/fixtures/invoice_fixture.csv'
    sales_engine = SalesEngine.from_csv({:invoices => path_and_filename})
    assert_instance_of InvoiceRepository, sales_engine.invoices
  end

  def test_it_returns_a_transaction_repo
    path_and_filename = './test/fixtures/transaction_fixture.csv'
    sales_engine = SalesEngine.from_csv({:transactions => path_and_filename})
    assert_instance_of TransactionRepository, sales_engine.transactions
  end

  def test_it_can_create_invoices_for_each_line_of_the_csv
    number_of_invoices = 99
    sales_engine = SalesEngine.from_csv({
      :invoices => './test/fixtures/invoice_fixture.csv'
    })
    assert_equal number_of_invoices, sales_engine.invoices.all.length
    assert sales_engine.invoices.find_by_id(40)
  end

  def test_it_can_create_merchants_for_each_line_of_the_csv
    number_of_merchants = 32
    sales_engine = SalesEngine.from_csv({
      :merchants => './test/fixtures/merchant_fixture.csv'
    })
    assert_equal number_of_merchants, sales_engine.merchants.all.length
    assert sales_engine.merchants.find_by_name("VectorCoast")
  end

  def test_it_can_create_items_for_each_line_of_the_csv
    number_of_items_in_file = 12
    sales_engine = SalesEngine.from_csv({
      :items => './test/fixtures/item_fixture.csv'
    })
    assert_equal number_of_items_in_file, sales_engine.items.all.length
    assert sales_engine.items.find_by_name("Anello nodo")
  end

  def test_it_can_find_items_by_merchant_id
    merchant_id = 12341234
    sales_engine = SalesEngine.from_csv({
      :items => './test/fixtures/item_fixture.csv'
    })
    results = sales_engine.find_items_by_merchant_id(merchant_id)
    assert_equal 7, results.length
  end

  def test_find_items_by_id_only_returns_items_for_specified_merchant
    merchant_id = 12341234
    sales_engine = SalesEngine.from_csv({
      :items => './test/fixtures/item_fixture.csv'
    })
    results = sales_engine.find_items_by_merchant_id(merchant_id)
    assert_equal 1, results.map(&:merchant_id).uniq.length
    assert_equal merchant_id, results.map(&:merchant_id).uniq.first
  end

  def test_it_can_find_invoices_by_merchant_id
    merchant_id = 12341234
    sales_engine = SalesEngine.from_csv({
      :invoices => './test/fixtures/invoice_fixture.csv'
    })
    results = sales_engine.find_invoices_by_merchant_id(merchant_id)
    assert_equal 9, results.length
    assert_equal merchant_id, results.map(&:merchant_id).uniq.first
  end

  def test_it_can_find_transactions_by_invoice_id
    invoice_id = 12341234
    sales_engine = SalesEngine.from_csv({
      :transactions => './test/fixtures/transaction_fixture.csv'
    })
    results = sales_engine.find_transactions_by_invoice_id(invoice_id)
    assert_equal 3, results.length
    assert_equal invoice_id, results.map(&:invoice_id).uniq.first
  end
end
