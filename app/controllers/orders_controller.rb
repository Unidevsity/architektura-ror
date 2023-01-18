class OrdersController < ApplicationController
  def create
    @order = Order.new(order_params)
    if @order.save
      render json: { order: order }
    else
      render json: { errors: order.errors.full_messages }, status: 422
    end
  end

  def update

    if order.update(order_params)
      render json: { order: order }
    else
      render json: { errors: order.errors.full_messages }, status: 422
    end
  end

  def destroy
    order.destroy
    render json: { message: 'Order deleted' }
  end

  private

  def order_params
    params.require(:order).permit(:user_id, order_lines_attributes: [:product_id, :quantity])
  end

  def order
    @order ||= Order.find(params[:id])
  end
end
