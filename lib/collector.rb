module Collector

  def collect_merchant_ids(customer_id)
    invoices
    .find_all_by_customer_id(customer_id)
    .map(&:merchant_id)
    .uniq
  end

  def collect_item_ids(invoice_id)
    invoice_items
    .find_all_by_invoice_id(invoice_id)
    .map(&:item_id)
  end

  def collect_customer_ids(merchant_id)
    invoices
    .find_all_by_merchant_id(merchant_id)
    .map(&:customer_id)
    .uniq
  end

  def collect_items(item_ids)
    item_ids.map do |id|
      items.find_by_id(id)
    end
  end

  def collect_customers(customer_ids)
    customer_ids.map do |id|
      customers.find_by_id(id)
    end
  end

  def collect_invoice_items(invoice_ids)
    invoice_ids.map do |id|
      invoice_items.find_all_by_invoice_id(id)
    end
  end

  def collect_merchants(merchant_ids)
    merchant_ids.map do |id|
      merchants.find_by_id(id)
    end
  end

  def collect_transactions_by_invoice_id(invoice_id)
    transactions.find_all_by_invoice_id(invoice_id)
  end
end
