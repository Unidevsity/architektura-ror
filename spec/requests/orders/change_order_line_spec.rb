describe 'Change order line', type: :request do
  let(:order) { create(:order) }
  let(:product) { create(:product) }
  let(:starting_quantity) { 3 }
  let(:order_line) { create(:order_line, order: order, product: product, quantity: starting_quantity) }

  before do
    patch "/orders/#{order.id}/order_lines/#{order_line.id}", params: { order_line: { quantity: new_quantity } }
  end

  context 'when increasing quantity' do
    let(:new_quantity) { 2 }

    it 'increases quantity' do
      json = JSON.parse(response.body)
      expect(json['order_line']['quantity']).to eq(starting_quantity + new_quantity)
    end
  end

  context 'when decreasing quantity' do
    let(:new_quantity) { -2 }

    it 'decreases quantity' do
      json = JSON.parse(response.body)
      expect(json['order_line']['quantity']).to eq(starting_quantity - new_quantity.abs)
    end

    context 'when starting quantity is 1' do
      let(:starting_quantity) { 1 }

      it 'deletes order line' do
        expect(OrderLine.count).to eq(0)
      end
    end

  end

end
