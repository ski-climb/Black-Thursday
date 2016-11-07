require_relative './import_engine'
require_relative './collector'
require_relative './finder'
require_relative './merchant_repository'
require_relative './item_repository'
require_relative './invoice_repository'
require_relative './transaction_repository'
require_relative './customer_repository'
require_relative './invoice_item_repository'
require_relative './importer'

class SalesEngine
  extend ImportEngine
  extend Finder
  extend Collector

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

  def self.invoice_paid_in_full?(invoice_id)
    results = collect_transactions_by_invoice_id(invoice_id)
    success?(results)
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
