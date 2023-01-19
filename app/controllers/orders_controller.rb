class OrdersController < ApplicationController
  def create
    order = OrdersService.new.create_order(order_params)
    if order.persisted?
      render json: { order: OrderSerializer.new(order) }, status: :created
    else
      render json: { errors: order.errors.full_messages }, status: 422
    end
  end

  def update
    order = OrdersService.new.update_order(params[:id], order_params)
    if order.persisted?
      render json: { order: OrderSerializer.new(order) }
    else
      render json: { errors: order.errors.full_messages }, status: 422
    end
  end

  def destroy
    order = OrdersService.new.destroy_order(params[:id])
    if order.destroyed?
      render json: { message: 'Order deleted' }
    else
      render json: { errors: order.errors.full_messages }, status: 422
    end
  end

  def total
    render json: { total: OrdersService.new.get_total(params[:id]) }
  end

  def show
    render json: { order: OrderSerializer.new(
      Orders::GetOrder.new(params[:id]).call
    ) }
  end

  def add_product
    order = OrdersService.new.add_product(params[:id], params[:product_id])
    if order.persisted?
      render json: { order: OrderSerializer.new(order) }
    else
      render json: { errors: order.errors.full_messages }, status: 422
    end
  end

  def remove_product
    order = Orders::RemoveProductFromOrder.new(params[:id], params[:product_id]).call
    if order.persisted?
      render json: { order: OrderSerializer.new(order) }
    else
      render json: { errors: order.errors.full_messages }, status: 422
    end
  end

  private

  def order_params
    params.require(:order).permit(:user_id, order_lines_attributes: [:product_id, :quantity])
  end

end
