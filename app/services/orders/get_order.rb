module Orders
  class GetOrder
    def initialize(order_id)
      @order_id = order_id
    end

    def call
      Order.find(@order_id)
    end
  end
end
