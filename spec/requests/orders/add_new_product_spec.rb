describe 'Add new product', type: :request do
  context 'when product does not exist' do
    it 'creates a new product' do
      post '/products', params: { product: { name: 'Product 1', description: 'Description 1', price_cents: 1000 } }
      expect(response).to have_http_status(:created)
      expect(response.body).to include('Product 1')
      expect(response.body).to include('Description 1')
      expect(response.body).to include('1000')
    end
  end

  context 'when product already exists' do
    let!(:product) { Product.create(name: 'Product 1', description: 'Description 1', price_cents: 1000) }

    it 'returns an error' do
      post '/products', params: { product: { name: 'Product 1', description: 'Description 1', price_cents: 1000 } }
      expect(response).to have_http_status(:unprocessable_entity)
      expect(response.body).to include('Name has already been taken')
    end
  end

  context 'when product description has vulgarisms' do
    it 'returns an error' do
      post '/products', params: { product: { name: 'Product 1', description: 'Description 1 dupa', price_cents: 1000 } }
      expect(response).to have_http_status(:unprocessable_entity)
      expect(response.body).to include('Description contains vulgarisms')
    end
  end

end
