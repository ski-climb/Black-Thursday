require 'csv'
require './lib/merchant_repository'
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
    import_merchants(data[:merchants]) if data[:merchants]
    import_items(data[:items]) if data[:items]
    self
  end

  def self.import_merchants(path_and_filename)
    Importer.new(path_and_filename, @all_merchants).import_merchants
  end

  def self.import_items(path_and_filename)
    Importer.new(path_and_filename, @all_items).import_items
  end
end

