require './lib/importer'

class SalesEngine

  def self.merchants
    @all_merchants
  end

  def self.items
    @all_items
  end

  def self.create_repositories
    @all_merchants = MerchantRepository.new
    @all_items = ItemRepository.new
  end

  def self.from_csv(data)
    create_repositories
    import(data)
    self
  end

  def self.import(data)
    import_merchants(data[:merchants]) if data[:merchants]
    import_items(data[:items]) if data[:items]
  end

  def self.import_merchants(path_and_filename)
    Importer.new(path_and_filename, @all_merchants).import_merchants
  end

  def self.import_items(path_and_filename)
    Importer.new(path_and_filename, @all_items).import_items
  end

  def self.find_items_by_merchant_id(id)
    items.find_all_by_merchant_id(id)
  end
end

