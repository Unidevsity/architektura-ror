describe 'Delete order', type: :request do
  let(:product) { create(:product) }
  let(:order_lines) do
    [
      create(:order_line, product: product, order: order),
    ]
  end
  let!(:order) { create(:order) }

  before do
    delete "/orders/#{order.id}"
  end

  it 'deletes an order' do
    expect(response).to have_http_status(:ok)
    json = JSON.parse(response.body)
    expect(json['message']).to eq('Order deleted')
  end

  it 'deletes an order with order lines' do
    expect(Order.count).to eq(0)
    expect(OrderLine.count).to eq(0)
  end
end
