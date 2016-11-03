require 'csv'
require_relative './merchant'
require_relative './item'
require_relative './invoice'

class Importer
  attr_reader :path_and_filename,
              :repository,
              :sales_engine

  def initialize(path_and_filename, repository, sales_engine)
    @path_and_filename = path_and_filename
    @repository = repository
    @sales_engine = sales_engine
  end

  def import_merchants
    add_merchants_to_repository(read_file)
    return repository
  end

  def import_items
    add_items_to_repository(read_file)
    return repository
  end

  def import_invoices
    add_invoices_to_repository(read_file)
    return repository
  end

  def read_file
    CSV.open(path_and_filename,
             headers: true,
             header_converters: :symbol)
  end

  def create_merchant(row)
    Merchant.new(
      :id           => row[:id],
      :name         => row[:name],
      :sales_engine => sales_engine)
  end

  def add_merchants_to_repository(contents)
    contents.each do |row|
      repository << create_merchant(row)
    end
  end

  def add_items_to_repository(contents)
    contents.each do |row|
      repository << create_item(row)
    end
  end

  def add_invoices_to_repository(contents)
    contents.each do |row|
      repository << create_invoice(row)
    end
  end

  def create_item(row)
    Item.new(
      :id           => row[:id],
      :name         => row[:name],
      :description  => row[:description],
      :merchant_id  => row[:merchant_id],
      :unit_price   => row[:unit_price],
      :created_at   => row[:created_at],
      :updated_at   => row[:updated_at],
      :sales_engine => sales_engine)
  end

  def create_invoice(row)
    Invoice.new(
      :id          => row[:id],
      :customer_id => row[:customer_id],
      :merchant_id => row[:merchant_id],
      :status      => row[:status],
      :created_at  => row[:created_at],
      :updated_at  => row[:updated_at],
    )
  end
end
