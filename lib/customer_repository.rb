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

  def find_by_id(id)
    all.find do |customer|
      customer.id == id
    end
  end

  def find_all_by_first_name(name)
    all.find_all do |customer|
      customer.first_name == name
    end
  end

  def find_all_by_last_name(name)
    all.find_all do |customer|
      customer.last_name == name
    end
  end

  def inspect; end
end
