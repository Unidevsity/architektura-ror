describe 'Create order', type: :request do
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
    post '/orders', params: { order: { order_lines_attributes: order_lines } }
  end


  it 'creates an order' do
    expect(response).to have_http_status(:created)
  end

  it 'creates an order with order lines' do
    json = JSON.parse(response.body)
    expect(json['order']).not_to be_nil
    expect(json['order']['order_lines'].count).to eq(1)
  end
end
