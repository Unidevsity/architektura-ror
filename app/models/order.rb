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
  include PriceConversion
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

  def total_in_full_number
    in_full_number(total_cents)
  end

  def total_in_currency(currency = 'USD')
    in_currency(total_cents, currency)
  end

  def total_cents
    order_lines.sum { |order_line| order_line.product.price_cents * order_line.quantity }
  end

  def add_product(product_id)
    order_line = order_lines.find_or_initialize_by(product_id: product_id)
    order_line.increment!(:quantity)
    order_line.save!
  end

  def remove_product(product_id)
    order_line = order_lines.find_by(product_id: product_id)
    order_line.quantity -= 1
    if order_line.quantity <= 0
      order_line.destroy
    end
    save!
  end


end
