module Orders
  class RemoveProductFromOrder
    def initialize(order_id, product_id)
      @order_id = order_id
      @product_id = product_id
    end

    def call
      order_line = order_lines.find_by(product_id: product_id)
      order_line.quantity -= 1
      if order_line.quantity <= 0
        order_line.destroy
      end
      order_line.save
      order
    end

    private

    attr_reader :product_id, :order_id

    def order
      @order ||= Order.find(order_id)
    end

    def product
      @product ||= Product.find(product_id)
    end

    def order_lines
      @order_lines ||= order.order_lines
    end
  end
end
