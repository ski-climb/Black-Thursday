class InvoiceRepository
  attr_reader :all

  def initialize
    @all = []
  end

  def <<(invoice)
    all.push(invoice)
  end

  def find_by_id(invoice_id)
    all.find do |invoice|
      invoice.id == invoice_id.to_i
    end
  end

  def find_all_by_customer_id(customer_id)
    all.find_all do |invoice|
      invoice.customer_id == customer_id.to_i
    end
  end

  def find_all_by_merchant_id(merchant_id)
    all.find_all do |invoice|
      invoice.merchant_id == merchant_id.to_i
    end
  end

  def find_all_by_status(status)
    all.find_all do |invoice|
      invoice.status == status
    end
  end

end
