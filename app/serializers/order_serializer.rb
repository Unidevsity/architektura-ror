class OrderSerializer < ActiveModel::Serializer
  attributes :id, :total, :order_lines_count

  has_many :order_lines

  def total
    object.order_lines.sum { |order_line| order_line.product.price_cents * order_line.quantity }
  end

  def order_lines_count
    object.order_lines.count
  end
end
