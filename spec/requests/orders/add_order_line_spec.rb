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

  context 'when product does not exist' do
    let(:product) { OpenStruct.new(id: 121231241412421) }

    it 'returns 404 error' do
      expect(response).to have_http_status(:not_found)
      json = JSON.parse(response.body)
      expect(json['message']).to eq "Could not find Product with id = #{product.id}"
    end
  end
end
