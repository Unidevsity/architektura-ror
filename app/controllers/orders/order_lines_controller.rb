module Orders
  class OrderLinesController < ApplicationController

    def create
      product = Product.find_by(id: order_line_params[:product_id])
      if product.nil?
        render json: { message: "Could not find Product with id = #{order_line_params[:product_id]}" }, status: :not_found
        return
      end

      order_line = order.order_lines.new(order_line_params)
      if order_line.save
        render json: { order_line: OrderLineSerializer.new(order_line) }, status: :created
      else
        render json: order_line.errors, status: :unprocessable_entity
      end
    end

    def update
      quantity_to_update = order_line_params[:quantity].to_i
      order_line.quantity = order_line.quantity + quantity_to_update

      if order_line.quantity > 0
        if order_line.save
          render json: { order_line: OrderLineSerializer.new(order_line) }, status: :ok
        else
          render json: order_line.errors, status: :unprocessable_entity
        end
      else
        destroy
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
