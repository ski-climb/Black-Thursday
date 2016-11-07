require_relative './merchant_repository'
require_relative './item_repository'
require_relative './invoice_repository'
require_relative './transaction_repository'
require_relative './customer_repository'
require_relative './invoice_item_repository'
require_relative './importer'

class SalesEngine

  def self.merchants
    @all_merchants
  end

  def self.items
    @all_items
  end

  def self.invoices
    @all_invoices
  end

  def self.transactions
    @all_transactions
  end

  def self.customers
    @all_customers
  end

  def self.invoice_items
    @all_invoice_items
  end

  def self.from_csv(data)
    import(data)
    self
  end

  def self.import(data)
    import_merchants(data[:merchants]) if data[:merchants]
    import_items(data[:items]) if data[:items]
    import_invoices(data[:invoices]) if data[:invoices]
    import_transactions(data[:transactions]) if data[:transactions]
    import_customers(data[:customers]) if data[:customers]
    import_invoice_items(data[:invoice_items]) if data[:invoice_items]
  end

  def self.import_merchants(path_and_filename)
    @all_merchants = MerchantRepository.new(self)
    contents = Importer.read_file(path_and_filename)
    @all_merchants.add_merchants(contents)
  end

  def self.import_items(path_and_filename)
    @all_items = ItemRepository.new(self)
    contents = Importer.read_file(path_and_filename)
    @all_items.add_items(contents)
  end

  def self.import_invoices(path_and_filename)
    @all_invoices = InvoiceRepository.new(self)
    contents = Importer.read_file(path_and_filename)
    @all_invoices.add_invoices(contents)
  end

  def self.import_transactions(path_and_filename)
    @all_transactions = TransactionRepository.new(self)
    contents = Importer.read_file(path_and_filename)
    @all_transactions.add_transactions(contents)
  end

  def self.import_customers(path_and_filename)
    @all_customers = CustomerRepository.new(self)
    contents = Importer.read_file(path_and_filename)
    @all_customers.add_customers(contents)
  end

  def self.import_invoice_items(path_and_filename)
    @all_invoice_items = InvoiceItemRepository.new(self)
    contents = Importer.read_file(path_and_filename)
    @all_invoice_items.add_invoice_items(contents)
  end

  def self.find_items_by_merchant_id(merchant_id)
    items.find_all_by_merchant_id(merchant_id)
  end

  def self.find_invoices_by_merchant_id(merchant_id)
    invoices.find_all_by_merchant_id(merchant_id)
  end

  def self.find_merchant_by_id(merchant_id)
    merchants.find_by_id(merchant_id)
  end

  def self.find_customer_by_id(customer_id)
    customers.find_by_id(customer_id)
  end

  def self.find_transactions_by_invoice_id(invoice_id)
    transactions.find_all_by_invoice_id(invoice_id)
  end

  def self.find_invoice_by_id(invoice_id)
    invoices.find_by_id(invoice_id)
  end

  def self.find_items_by_invoice_id(invoice_id)
    list_of_item_ids = collect_item_ids(invoice_id)
    collect_items(list_of_item_ids)
  end

  def self.find_customers_by_merchant_id(merchant_id)
    list_of_customer_ids = collect_customer_ids(merchant_id)
    collect_customers(list_of_customer_ids)
  end

  def self.find_merchants_by_customer_id(customer_id)
    list_of_merchant_ids = collect_merchant_ids(customer_id)
    collect_merchants(list_of_merchant_ids)
  end

  def self.find_all_invoice_items_by_invoice_id(invoice_id)
    invoice_items.find_all_by_invoice_id(invoice_id)
  end

  def self.collect_merchant_ids(customer_id)
    invoices
    .find_all_by_customer_id(customer_id)
    .map(&:merchant_id)
    .uniq
  end

  def self.collect_item_ids(invoice_id)
    invoice_items
    .find_all_by_invoice_id(invoice_id)
    .map(&:item_id)
  end

  def self.collect_customer_ids(merchant_id)
    invoices
    .find_all_by_merchant_id(merchant_id)
    .map(&:customer_id)
    .uniq
  end

  def self.collect_items(item_ids)
    item_ids.map do |id|
      items.find_by_id(id)
    end
  end

  def self.collect_customers(customer_ids)
    customer_ids.map do |id|
      customers.find_by_id(id)
    end
  end

  def self.collect_merchants(merchant_ids)
    merchant_ids.map do |id|
      merchants.find_by_id(id)
    end
  end

  def self.invoice_paid_in_full?(invoice_id)
    results = collect_transactions_by_invoice_id(invoice_id)
    success?(results)
  end

  def self.collect_transactions_by_invoice_id(invoice_id)
    transactions.find_all_by_invoice_id(invoice_id).map(&:result)
  end

  def self.success?(results)
    !results.empty? && results.all? { |result| result == "success" }
  end

  def self.total_price_by_invoice(invoice_id)
    return 0 unless invoice_paid_in_full?(invoice_id)
    sum_of_items_on_invoice(invoice_id)
  end

  def self.sum_of_items_on_invoice(invoice_id)
    find_all_invoice_items_by_invoice_id(invoice_id)
    .map do |invoice_item|
      invoice_item.unit_price * invoice_item.quantity.to_i
    end.reduce(:+)
  end
end
