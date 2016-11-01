class Invoice

  attr_reader :id,
              :customer_id,
              :merchant_id,
              :status

  def initialize(data)
    @id = data[:id]
    @customer_id = data[:customer_id]
    @merchant_id = data[:merchant_id]
    @status = data[:status]
  end

end