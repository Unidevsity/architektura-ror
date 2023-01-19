# frozen_string_literal: true

describe Orders::RemoveProductFromOrder do
  let!(:order) { create(:order) }
  let!(:product) { create(:product) }

  context 'when product is in order' do
    let!(:order_line) { create(:order_line, order: order, product: product, quantity: 1) }

    it 'removes product from order' do
      described_class.new(order.id, product.id).call

      expect(order.order_lines.count).to eq(0)
    end
  end

  context 'when product is in order with quantity bigger than 1' do
    let!(:order_line) { create(:order_line, order: order, product: product, quantity: 2) }

    it 'decreases quantity of order line' do
      described_class.new(order.id, product.id).call

      expect(order_line.reload.quantity).to eq(1)
    end
  end

end
