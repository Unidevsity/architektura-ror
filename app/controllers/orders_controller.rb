class OrdersController < ApplicationController
  def create
    @order = Order.new(order_params)
    if @order.save
      render json: { order: OrderSerializer.new(order) }, status: :created
    else
      render json: { errors: order.errors.full_messages }, status: 422
    end
  end

  def update
    if order.update_lines(order_params[:order_lines_attributes])
      render json: { order: OrderSerializer.new(order) }
    else
      render json: { errors: order.errors.full_messages }, status: 422
    end
  end

  def destroy
    if order.destroy
      render json: { message: 'Order deleted' }
    else
      render json: { errors: order.errors.full_messages }, status: 422
    end
  end

  def total
    render json: { total: order.total }
  end

  def show
    render json: { order: OrderSerializer.new(order) }
  end

  private

  def order_params
    params.require(:order).permit(:user_id, order_lines_attributes: [:product_id, :quantity])
  end

  def order
    @order ||= Order.find(params[:id])
  end
end
