describe Orders::CreateOrder do
  context 'when order lines are valid' do
    let(:order_params) do
      {
        order_lines_attributes: [
          { product_id: create(:product).id, quantity: 1 },
          { product_id: create(:product).id, quantity: 1 }
        ]
      }
    end

    subject(:command) { described_class.new(order_params) }

    it 'succeeds' do
      expect(command.call).to be_success
      expect(command.call.success?).to be_truthy
    end

    it 'creates an order' do
      expect { command.call }.to change { Order.count }.by(1)
    end
  end

  context 'when order lines are invalid' do
    let(:product) { create(:product) }

    let(:order_params) do
      {
        order_lines_attributes: [
          { product_id: product.id, quantity: 1 },
          { product_id: product.id, quantity: 1 },
          { product_id: product.id, quantity: 1 }
        ]
      }
    end

    subject(:command) { described_class.new(order_params) }

    it 'fails' do
      expect(command.call).to be_failure
      expect(command.call.failure?).to be_truthy
    end

    it 'does not create an order' do
      expect { command.call }.not_to change { Order.count }
    end
  end
end
