# == Schema Information
#
# Table name: order_lines
#
#  id         :integer          not null, primary key
#  line_total :integer          default(0)
#  quantity   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  order_id   :integer
#  product_id :integer
#
# Indexes
#
#  index_order_lines_on_order_id    (order_id)
#  index_order_lines_on_product_id  (product_id)
#
class OrderLineSerializer < ActiveModel::Serializer
  attributes :id, :quantity, :product_id, :order_id
end
