describe 'Delete order line', type: :request do
  let(:order) { create(:order) }

  let(:product) { create(:product) }
  let(:order_lines) do
    [
      create(:order_line, product: product, order: order),
    ]
  end

  before do
    delete "/orders/#{order.id}/order_lines/#{order_lines.first.id}"
  end

  it 'deletes an order line' do
    expect(response).to have_http_status(:ok)
    json = JSON.parse(response.body)
    expect(json['message']).to eq('Order line deleted')
  end
end
