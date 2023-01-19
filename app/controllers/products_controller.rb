class ProductsController < ApplicationController

  def create
    create_product = Products::Create.new(product_params)
    product = create_product.call
    if product.persisted?
      render json: product, status: :created
    else
      render json: product.errors, status: :unprocessable_entity
    end
  end

  private

  def product_params
    params.require(:product).permit(:name, :description, :price_cents)
  end
end
