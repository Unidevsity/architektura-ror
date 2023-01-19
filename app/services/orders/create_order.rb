module Orders
  class CreateOrder
    prepend SimpleCommand

    def initialize(order_params)
      @order_params = order_params
    end

    def call
      validate_order_lines
      return nil if errors.any?
      order = Order.new(order_params)
      order.save!
      order
    end

    private

    attr_reader :order_params

    def validate_order_lines
      order_lines = order_params[:order_lines_attributes]
      order_lines.each do |hash|
        if order_lines.count { |h| h[:product_id] == hash[:product_id] } > 1
          errors.add(:order_lines, 'Cannot create multiple order lines with the same product')
        end
      end
    end
  end
end
