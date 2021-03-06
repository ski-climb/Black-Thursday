require_relative './transaction'

class TransactionRepository
  attr_reader :all,
              :sales_engine

  def initialize(sales_engine)
    @all = []
    @sales_engine = sales_engine
  end

  def <<(transaction)
    all.push(transaction)
  end

  def add_transactions(data)
    data.each do |row|
      all << Transaction.new(row, sales_engine)
    end
  end

  def find_by_id(transaction_id)
    all.find do |transaction|
      transaction.id == transaction_id.to_i
    end
  end

  def find_all_by_result(result)
    all.find_all do |transaction|
      transaction.result == result
    end
  end

  def find_all_by_credit_card_number(credit_card_number)
    all.find_all do |transaction|
      transaction.credit_card_number == credit_card_number.to_i
    end
  end

  def find_all_by_invoice_id(invoice_id)
    all.find_all do |transaction|
      transaction.invoice_id == invoice_id
    end
  end

  def inspect; end
end
