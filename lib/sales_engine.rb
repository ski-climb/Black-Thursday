require_relative './merchant_repository'
require_relative './item_repository'
require_relative './invoice_repository'
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

  def self.from_csv(data)
    import(data)
    self
  end

  def self.import(data)
    import_merchants(data[:merchants]) if data[:merchants]
    import_items(data[:items]) if data[:items]
    import_invoices(data[:invoices]) if data[:invoices]
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

  def self.find_items_by_merchant_id(id)
    items.find_all_by_merchant_id(id)
  end

  def self.find_invoices_by_merchant_id(id)
    invoices.find_all_by_merchant_id(id)
  end

  def self.find_merchant_by_item_id(id)
    merchants.find_by_id(id)
  end

  def self.find_merchant_by_invoice_id(id)
    merchants.find_by_id(id)
  end
end

