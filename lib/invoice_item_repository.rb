class InvoiceItemRepository
  attr_reader :all

  def initialize(sales_engine)
    @all = []
  end

  def <<(invoice_item)
    all.push(invoice_item)
  end

  def find_by_id(id)
    all.find do |invoice_item|
      invoice_item.id == id
    end
  end

  def find_by_invoice_id(invoice_id)
    all.find_all do |invoice_item|
      invoice_item.invoice_id == invoice_id
    end
  end

  def find_by_item_id(item_id)
    all.find_all do |invoice_item|
      invoice_item.item_id == item_id
    end
  end

  def inspect; end
end
