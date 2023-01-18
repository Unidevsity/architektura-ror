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
    order_lines = order_params[:order_lines_attributes]
    order_lines.each do |order_line|
      if order.order_lines.find_by(product_id: order_line[:product_id])
        order_line[:quantity] = order_line[:quantity].to_i + order.order_lines.find_by(product_id: order_line[:product_id]).quantity
        order.order_lines.find_by(product_id: order_line[:product_id]).build(quantity: order_line[:quantity])
      else
        order.order_lines.build(order_line)
      end
    end

    if order.save
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
    total = order.order_lines.sum { |order_line| order_line.product.price_cents * order_line.quantity }
    render json: { total: total }
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
