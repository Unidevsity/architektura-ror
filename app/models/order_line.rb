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
  belongs_to :product

  class ProductNotFound < StandardError; end

  def self.create_from_params(order, order_line_params)
    product = Product.find_by(id: order_line_params[:product_id])
    if product.nil?
      raise ProductNotFound, "Could not find Product with id = #{order_line_params[:product_id]}"
    end

    order.order_lines.create!(order_line_params)
  end

  def update_quantity(quantity_to_update)
    self.quantity = quantity + quantity_to_update
    if quantity <= 0
      destroy
    else
      save!
    end
  end

  def line_total
    product.price_cents * quantity
  end

end
