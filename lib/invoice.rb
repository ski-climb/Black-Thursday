require 'chronic'

class Invoice

  attr_reader :id,
              :customer_id,
              :merchant_id,
              :status,
              :created_at,
              :updated_at

  def initialize(data)
    @id = data[:id].to_s
    @customer_id = data[:customer_id].to_s
    @merchant_id = data[:merchant_id].to_s
    @status = data[:status]
    @created_at = Chronic.parse(data[:created_at])
    @updated_at = Chronic.parse(data[:updated_at])
  end

end
