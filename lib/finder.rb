module Finder

  def find_items_by_merchant_id(merchant_id)
    items.find_all_by_merchant_id(merchant_id)
  end

  def find_invoices_by_merchant_id(merchant_id)
    invoices.find_all_by_merchant_id(merchant_id)
  end

  def find_merchant_by_id(merchant_id)
    merchants.find_by_id(merchant_id)
  end

  def find_customer_by_id(customer_id)
    customers.find_by_id(customer_id)
  end

  def find_transactions_by_invoice_id(invoice_id)
    transactions.find_all_by_invoice_id(invoice_id)
  end

  def find_invoice_by_id(invoice_id)
    invoices.find_by_id(invoice_id)
  end

  def find_items_by_invoice_id(invoice_id)
    list_of_item_ids = collect_item_ids(invoice_id)
    collect_items(list_of_item_ids)
  end

  def find_customers_by_merchant_id(merchant_id)
    list_of_customer_ids = collect_customer_ids(merchant_id)
    collect_customers(list_of_customer_ids)
  end

  def find_merchants_by_customer_id(customer_id)
    list_of_merchant_ids = collect_merchant_ids(customer_id)
    collect_merchants(list_of_merchant_ids)
  end

  def find_all_invoice_items_by_invoice_id(invoice_id)
    invoice_items.find_all_by_invoice_id(invoice_id)
  end

  def find_all_invoices_by_date(date)
    invoices.find_all_by_created_at(date)
  end
end
