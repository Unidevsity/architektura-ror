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
class Product < ApplicationRecord
  include PriceConversion
  class ProductAlreadyExists < StandardError; end

  validates :name, presence: true, uniqueness: true
  validates :description, presence: true, length: { maximum: 1000 }
  validates :price_cents, presence: true, numericality: { greater_than: 0 }

end
