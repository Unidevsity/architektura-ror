class ProductsController < ApplicationController

  def create
    product_form = ProductForm.new(product_params)
    if product_form.save
      render json: product_form.product, status: :created
    else
      render json: product_form.errors, status: :unprocessable_entity
    end
  end

  private

  def product_params
    params.require(:product).permit(:name, :description, :price_cents)
  end
end
