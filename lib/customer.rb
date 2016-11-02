require 'chronic'

class Customer

  attr_reader :id,
              :first_name,
              :last_name,
              :created_at,
              :updated_at
              
  def initialize(data)
    @id = data[:id].to_s
    @first_name = data[:first_name]
    @last_name = data[:last_name]
    @created_at = Chronic.parse(data[:created_at])
    @updated_at = Chronic.parse(data[:updated_at])
  end
end
