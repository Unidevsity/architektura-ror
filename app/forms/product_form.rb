class ProductForm
  include ActiveModel::Model

  validates :description, length: { maximum: 1000 }
  validate :description_vulgarisms
  validates :price_cents, numericality: { greater_than: 0 }

  attr_reader :product
  attr_accessor :name, :description, :price_cents

  def save
    return false if invalid?

    if Product.exists?(name: name)
      errors.add(:name, 'Name has already been taken')
      return false
    end

    @product = Product.create!(name: name, description: description, price_cents: price_cents)
  end

  private

  attr_reader :name, :description, :price_cents

  def description_vulgarisms
    return unless description.include?('dupa')

    errors.add(:description, 'Description contains vulgarisms')
  end

end
