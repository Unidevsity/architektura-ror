describe OrdersController do
  let(:product) { create(:product) }
  let(:order_lines) do
    [
      { product_id: product.id, quantity: 1 }
    ]
  end

  let(:orders_service) { OrdersService.new }

  before do
    allow(OrdersService).to receive(:new).and_return(orders_service)
    allow(orders_service).to receive(:create_order).and_call_original
    allow(orders_service).to receive(:update_order).and_call_original
    allow(orders_service).to receive(:destroy_order).and_call_original
    allow(orders_service).to receive(:add_product).and_call_original
    allow(orders_service).to receive(:remove_product).and_call_original
    allow(orders_service).to receive(:get_order).and_call_original
  end

  describe 'POST #create' do
    subject(:create_request) do
      post :create, params: { order: { order_lines_attributes: order_lines } }

    end
    it 'creates a new order' do
      expect do
        create_request
      end.to change(Order, :count).by(1)
    end

    it 'calls OrdersService' do
      expect(Orders::CreateOrder).to receive(:call).and_call_original
      create_request
    end
  end

  describe 'PUT #update' do
    let!(:order) { create(:order) }

    it 'updates an order' do
      put :update, params: { id: order.id, order: { order_lines_attributes: order_lines } }
      expect(order.reload.order_lines.first.product_id).to eq(product.id)
      expect(order.reload.order_lines.first.quantity).to eq(1)
    end
  end

  describe 'DELETE #destroy' do
    let!(:order) { create(:order) }

    it 'deletes an order' do
      expect do
        delete :destroy, params: { id: order.id }
      end.to change(Order, :count).by(-1)
    end

  end

  describe 'GET #total' do
    let!(:order) { create(:order) }
    let(:quantity) { 2 }
    let(:product1) { create(:product, price_cents: 1000) }
    let(:product2) { create(:product, price_cents: 2000) }
    let!(:order_lines) do
      [
        create(:order_line, product_id: product1.id, quantity: quantity, order: order),
        create(:order_line, product_id: product2.id, quantity: quantity, order: order)
      ]
    end

    it 'returns the total of an order' do
      get :total, params: { id: order.id }
      expect(response).to have_http_status(:ok)
      json = JSON.parse(response.body)
      expect(json['total']).to eq quantity * product1.price_cents + quantity * product2.price_cents
    end
  end

  describe 'GET #show' do
    let!(:order) { create(:order) }
    let(:quantity) { 2 }
    let(:product1) { create(:product, price_cents: 1000) }
    let(:product2) { create(:product, price_cents: 2000) }
    let!(:order_lines) do
      [
        create(:order_line, product_id: product1.id, quantity: quantity, order: order),
        create(:order_line, product_id: product2.id, quantity: quantity, order: order)
      ]
    end

    it 'returns the total of an order' do
      get :show, params: { id: order.id }
      expect(response).to have_http_status(:ok)
      json = JSON.parse(response.body)
      expect(json['order']['order_lines'].count).to eq 2
      expect(json['order']['order_lines_count']).to eq 2
      expect(json['order']['total']).to eq quantity * product1.price_cents + quantity * product2.price_cents
    end
  end

  describe 'POST #close' do
    # case 1
    # case 2
    # case 3
    # case 4
    # case 5
    # case 6
    # case 7
    # case.........
  end

end
