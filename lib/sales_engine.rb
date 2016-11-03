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

  def self.create_repositories
    @all_merchants = MerchantRepository.new
    @all_items = ItemRepository.new
    @all_invoices = InvoiceRepository.new
  end

  def self.from_csv(data)
    create_repositories
    import(data)
    self
  end

  def self.import(data)
    import_merchants(data[:merchants]) if data[:merchants]
    import_items(data[:items]) if data[:items]
    import_invoices(data[:invoices]) if data[:invoices]
  end

  def self.import_merchants(path_and_filename)
    Importer.new(path_and_filename, @all_merchants, self).import_merchants
  end

  def self.import_items(path_and_filename)
    Importer.new(path_and_filename, @all_items, self).import_items
  end

  def self.import_invoices(path_and_filename)
    Importer.new(path_and_filename, @all_invoices, self).import_invoices
  end

  def self.find_items_by_merchant_id(id)
    items.find_all_by_merchant_id(id)
  end

  def self.find_merchant_by_item_id(id)
    merchants.find_by_id(id)
  end
end

