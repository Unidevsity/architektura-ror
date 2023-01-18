describe 'Add product to order', type: :request do
  let!(:order) { create(:order) }
  let!(:product) { create(:product) }

  context 'when product is not in order' do
    it 'adds a product to an order' do
      post "/orders/#{order.id}/add_product", params: { product_id: product.id }
      expect(response).to have_http_status(:ok)
      json = JSON.parse(response.body)
      expect(json['order']['order_lines'].count).to eq 1
      expect(json['order']['order_lines_count']).to eq 1
      expect(json['order']['total']).to eq product.price_cents
    end
  end

  context 'when product is already in order' do
    let!(:order_line) { create(:order_line, product: product, order: order) }

    it 'adds a product to an order' do
      post "/orders/#{order.id}/add_product", params: { product_id: product.id }
      expect(response).to have_http_status(:ok)
      json = JSON.parse(response.body)
      expect(json['order']['order_lines'].count).to eq 1
      expect(json['order']['order_lines_count']).to eq 1
      expect(json['order']['order_lines'][0]['quantity']).to eq 2
      expect(json['order']['total']).to eq 2 * product.price_cents
    end
  end
end
