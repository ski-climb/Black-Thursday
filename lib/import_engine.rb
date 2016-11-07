module ImportEngine

  def import(data)
    import_merchants(data[:merchants]) if data[:merchants]
    import_items(data[:items]) if data[:items]
    import_invoices(data[:invoices]) if data[:invoices]
    import_transactions(data[:transactions]) if data[:transactions]
    import_customers(data[:customers]) if data[:customers]
    import_invoice_items(data[:invoice_items]) if data[:invoice_items]
  end

  def import_merchants(path_and_filename)
    @all_merchants = MerchantRepository.new(self)
    contents = Importer.read_file(path_and_filename)
    @all_merchants.add_merchants(contents)
  end

  def import_items(path_and_filename)
    @all_items = ItemRepository.new(self)
    contents = Importer.read_file(path_and_filename)
    @all_items.add_items(contents)
  end

  def import_invoices(path_and_filename)
    @all_invoices = InvoiceRepository.new(self)
    contents = Importer.read_file(path_and_filename)
    @all_invoices.add_invoices(contents)
  end

  def import_transactions(path_and_filename)
    @all_transactions = TransactionRepository.new(self)
    contents = Importer.read_file(path_and_filename)
    @all_transactions.add_transactions(contents)
  end

  def import_customers(path_and_filename)
    @all_customers = CustomerRepository.new(self)
    contents = Importer.read_file(path_and_filename)
    @all_customers.add_customers(contents)
  end

  def import_invoice_items(path_and_filename)
    @all_invoice_items = InvoiceItemRepository.new(self)
    contents = Importer.read_file(path_and_filename)
    @all_invoice_items.add_invoice_items(contents)
  end
end
