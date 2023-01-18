describe OrdersController do
  let(:product) { create(:product) }
  let(:order_lines) do
    [
      { product_id: product.id, quantity: 1 }
    ]
  end

  describe 'POST #create' do
    it 'creates a new order' do
      expect do
        post :create, params: { order: { order_lines_attributes: order_lines } }
      end.to change(Order, :count).by(1)
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

end
