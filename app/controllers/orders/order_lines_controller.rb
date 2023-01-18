module Orders
  class OrderLinesController < ApplicationController

    def create
      order_line = OrderLine.create_from_params(order, order_line_params)
      if order_line
        render json: { order_line: OrderLineSerializer.new(order_line) }, status: :created
      else
        render json: order_line.errors, status: :unprocessable_entity
      end
    rescue OrderLine::ProductNotFound => e
      render json: { message: e.message }, status: :not_found
    end

    def update
      quantity_to_update = order_line_params[:quantity].to_i
      if order_line.update_quantity(quantity_to_update)
        render json: { order_line: OrderLineSerializer.new(order_line) }, status: :ok
      else
        render json: order_line.errors, status: :unprocessable_entity
      end
    end

    def destroy
      if order_line.destroy
        render json: { message: 'Order line deleted' }
      else
        render json: order_line.errors, status: :unprocessable_entity
      end
    end

    private

    def order_line_params
      params.require(:order_line).permit(:order_id, :product_id, :quantity)
    end

    def order_line
      @order_line ||= order.order_lines.find(params[:id])
    end

    def order
      @order ||= Order.find(params[:order_id])
    end
  end
end
