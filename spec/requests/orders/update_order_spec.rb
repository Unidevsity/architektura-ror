describe 'Update order', type: :request do
  let(:order) { create(:order) }
  let(:product) { create(:product) }
  let(:order_lines) do
    [
      {
        product_id: product.id,
        quantity: 1
      }
    ]
  end

  before do
    put "/orders/#{order.id}", params: { order: { order_lines_attributes: order_lines } }
  end

  it 'updates an order' do
    expect(response).to have_http_status(:ok)
  end

  it 'updates an order with order lines' do
    json = JSON.parse(response.body)
    expect(json['order']).not_to be_nil
    expect(json['order']['order_lines'].count).to eq(1)
  end


end
