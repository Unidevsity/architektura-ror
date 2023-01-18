class OrderSerializer < ActiveModel::Serializer
  attributes :id, :total, :order_lines_count

  has_many :order_lines

  def order_lines_count
    object.order_lines.count
  end
end
