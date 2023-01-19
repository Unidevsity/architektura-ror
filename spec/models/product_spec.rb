# frozen_string_literal: true

# == Schema Information
#
# Table name: products
#
#  id          :integer          not null, primary key
#  description :string
#  name        :string
#  price_cents :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
describe Product, type: :model do
  describe '#price_in_full_number' do
    it 'returns the price in full number' do
      product = Product.new(price_cents: 1000)
      expect(product.price_in_full_number).to eq("10.00")
    end
  end

  describe '#price_in_currency' do
    it 'returns the price in the currency' do
      product = Product.new(price_cents: 1000)
      expect(product.price_in_currency('EUR')).to eq("10.00 EUR")
    end
  end
end
