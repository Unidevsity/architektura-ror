# frozen_string_literal: true

# == Schema Information
#
# Table name: order_lines
#
#  id         :integer          not null, primary key
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
class OrderLine < ApplicationRecord
  belongs_to :order, inverse_of: :order_lines
  belongs_to :product, inverse_of: :order_lines
end
