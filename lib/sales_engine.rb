require 'csv'
require './lib/merchant_repository'
require './lib/importer'

class SalesEngine

  def self.from_csv(data)
    import_merchants(data[:merchants]) if data[:merchants]
    self
  end

  def self.import_merchants(path_and_filename)
    @all_merchants = MerchantRepository.new
    Importer.new(path_and_filename, @all_merchants).import_merchants
  end

  def self.merchants
    @all_merchants
  end

end

