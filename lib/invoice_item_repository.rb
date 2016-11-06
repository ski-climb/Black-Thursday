require_relative './invoice_item'

class InvoiceItemRepository
  attr_reader :all,
              :sales_engine

  def initialize(sales_engine)
    @all = []
    @sales_engine = sales_engine
  end

  def <<(invoice_item)
    all.push(invoice_item)
  end

  def add_invoice_items(data)
    data.each do |row|
      all << InvoiceItem.new(row, sales_engine)
    end
  end

  def find_by_id(id)
    all.find do |invoice_item|
      invoice_item.id == id
    end
  end

  def find_all_by_invoice_id(invoice_id)
    all.find_all do |invoice_item|
      invoice_item.invoice_id == invoice_id
    end
  end

  def find_all_by_item_id(item_id)
    all.find_all do |invoice_item|
      invoice_item.item_id == item_id
    end
  end

  def inspect; end
end
