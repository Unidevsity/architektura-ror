describe 'Add order line', type: :request do
  let(:product) { create(:product) }
  let!(:order) { create(:order) }
  let(:order_line) do
      {
        product_id: product.id,
        quantity: 1
      }
  end

  before do
    post "/orders/#{order.id}/order_lines", params: { order_line: order_line }
  end

  it 'adds an order line' do
    expect(response).to have_http_status(:created)
  end

  it 'adds an order line to an order' do
    json = JSON.parse(response.body)

    expect(json['order_line']).not_to be_nil
    expect(json['order_line']['order_id']).to eq order.id
  end
end
