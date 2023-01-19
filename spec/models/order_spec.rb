# frozen_string_literal: true

# == Schema Information
#
# Table name: orders
#
#  id         :integer          not null, primary key
#  status     :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
describe Order, type: :model do
  describe '#total_in_full_number' do
    it 'returns the total in full number' do
      order = Order.new
      order.order_lines.build(product: Product.new(price_cents: 1000), quantity: 1)
      order.order_lines.build(product: Product.new(price_cents: 2000), quantity: 2)
      expect(order.total_in_full_number).to eq("50.00")
    end
  end

  describe '#total_in_currency' do
    it 'returns the total in the currency' do
      order = Order.new
      order.order_lines.build(product: Product.new(price_cents: 1000), quantity: 1)
      order.order_lines.build(product: Product.new(price_cents: 2000), quantity: 2)
      expect(order.total_in_currency('EUR')).to eq("50.00 EUR")
    end
  end
end

