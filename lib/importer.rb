require 'csv'
require './lib/merchant'
require './lib/item'

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

  def import_items
    add_items_to_repository(read_file)
    return repository
  end

  def read_file
    CSV.open(path_and_filename,
             headers: true,
             header_converters: :symbol)
  end

  def create_merchant(row)
    merchant = Merchant.new(
      :id   => row[:id],
      :name => row[:name])
  end

  def add_merchants_to_repository(contents)
    contents.each do |row|
      merchant = create_merchant(row)
      repository << merchant
    end
  end

  def add_items_to_repository(contents)
    contents.each do |row|
      item = create_item(row)
      repository << item
    end
  end

  def create_item(row)
    item = Item.new(
      :id          => row[:id],
      :name        => row[:name],
      :description => row[:description],
      :merchant_id => row[:merchant_id],
      :unit_price  => row[:unit_price],
      :created_at  => row[:created_at],
      :updated_at  => row[:updated_at])
  end
end
