require 'chronic'
require 'bigdecimal'

class InvoiceItem

  attr_reader :id,
              :item_id,
              :invoice_id,
              :quantity,
              :unit_price,
              :created_at,
              :updated_at

  def initialize(data)
    @id = data[:id]
    @item_id = data[:item_id]
    @invoice_id = data[:invoice_id]
    @quantity = data[:quantity]
    @unit_price = BigDecimal.new(data[:unit_price], 4)
    @created_at = Chronic.parse(data[:created_at])
    @updated_at = Chronic.parse(data[:updated_at])
  end

  def unit_price_to_dollars
    (unit_price / BigDecimal.new(100)).to_f
  end
end
