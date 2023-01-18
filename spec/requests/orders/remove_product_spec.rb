describe 'Remove product from order', type: :request do
  let!(:order) { create(:order) }
  let!(:product) { create(:product) }
  let!(:order_line) { create(:order_line, product: product, order: order) }

  context 'when product is in order' do
    it 'removes a product from an order' do
      post "/orders/#{order.id}/remove_product", params: { product_id: product.id }
      expect(response).to have_http_status(:ok)
      json = JSON.parse(response.body)
      expect(json['order']['order_lines'].count).to eq 0
      expect(json['order']['order_lines_count']).to eq 0
      expect(json['order']['total']).to eq 0
    end
  end

  context 'when only 1 product left in order' do
    let!(:order_line2) { create(:order_line, product: product, order: order) }

    it 'removes a product from an order' do
      post "/orders/#{order.id}/remove_product", params: { product_id: product.id }
      expect(response).to have_http_status(:ok)
      json = JSON.parse(response.body)
      expect(json['order']['order_lines'].count).to eq 1
      expect(json['order']['order_lines_count']).to eq 1
      expect(json['order']['total']).to eq product.price_cents
    end
  end

  context 'when product is not in order' do
    it 'removes a product from an order' do
      post "/orders/#{order.id}/remove_product", params: { product_id: product.id }
      expect(response).to have_http_status(:ok)
      json = JSON.parse(response.body)
      expect(json['order']['order_lines'].count).to eq 0
      expect(json['order']['order_lines_count']).to eq 0
      expect(json['order']['total']).to eq 0
    end
  end


end
