# == Schema Information
#
# Table name: orders
#
#  id         :integer          not null, primary key
#  status     :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Order < ApplicationRecord
  has_many :order_lines, dependent: :destroy, inverse_of: :order, autosave: true

  accepts_nested_attributes_for :order_lines, reject_if: :all_blank, allow_destroy: true

  def update_lines(order_lines_attributes)
    order_lines_attributes.each do |order_line|
      if order_lines.find_by(product_id: order_line[:product_id])
        order_line[:quantity] = order_line[:quantity].to_i + order_lines.find_by(product_id: order_line[:product_id]).quantity
        order_lines.find_by(product_id: order_line[:product_id]).build(quantity: order_line[:quantity])
      else
        order_lines.build(order_line)
      end
    end
    save!
  end

  def total
    order_lines.sum { |order_line| order_line.product.price_cents * order_line.quantity }
  end
end
