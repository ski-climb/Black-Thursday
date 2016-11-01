require 'csv'
require './lib/merchant'

class Importer
  attr_reader :path_and_filename,
              :repository

  def initialize(path_and_filename, repository)
    @path_and_filename = path_and_filename
    @repository = repository
  end

  def import_merchants
    add_merchants_to_repository(read_file)
    return repository
  end

  def read_file
    CSV.open(path_and_filename, headers: true, header_converters: :symbol)
  end

  def create_merchant(row)
    id   = row[:id]
    name = row[:name]
    merchant = Merchant.new(
      :id   => id,
      :name => name)
    return merchant
  end

  def add_merchants_to_repository(contents)
    contents.each do |row|
      merchant = create_merchant(row)
      repository << merchant
    end
  end
end
