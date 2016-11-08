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
    transactions = collect_transactions_by_invoice_id(invoice_id)
    success?(transactions)
  end

  def self.success?(transactions)
    !transactions.map(&:result).empty? && \
    transactions.any? { |t| t.result == "success" }
  end

  def self.successfully_charged_total_for_invoice(invoice_id)
    return 0 unless invoice_paid_in_full?(invoice_id)
    total_cost_of_all_items_on_invoice(invoice_id)
  end

  def self.total_cost_of_all_items_on_invoice(invoice_id)
    # TODO
    # the second half of this method should be broken out
    find_all_invoice_items_by_invoice_id(invoice_id)
    .map do |invoice_item|
      invoice_item.unit_price * invoice_item.quantity.to_i
    end.reduce(:+)
  end
end
