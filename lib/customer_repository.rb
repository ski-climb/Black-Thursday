require_relative './customer'

class CustomerRepository
  attr_reader :all,
              :sales_engine

  def initialize(sales_engine)
    @all = []
    @sales_engine = sales_engine
  end

  def <<(customer)
    all.push(customer)
  end

  def add_customers(data)
    data.each do |row|
      all << Customer.new(row, sales_engine)
    end
  end

  def find_by_id(customer_id)
    all.find do |customer|
      customer.id == customer_id
    end
  end

  def find_all_by_first_name(name)
    all.find_all do |customer|
      customer.first_name.downcase.include?(name.downcase)
    end
  end

  def find_all_by_last_name(name)
    all.find_all do |customer|
      customer.last_name.downcase.include?(name.downcase)
    end
  end

  def inspect; end
end
