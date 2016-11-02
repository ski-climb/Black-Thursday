class Merchant

  attr_reader :id,
              :name

  def initialize(data)
    @id = data[:id].to_s
    @name = data[:name]
  end

end
