class OrdersService

  def create_order(order_params)
    order = Order.new(order_params)
    order.save!
    order
  end

  def update_order(order_id, order_params)
    order = get_order(order_id)
    order.update!(order_params)
    order
  end

  def destroy_order(order_id)
    order = get_order(order_id)
    order.destroy!
    order
  end

  def get_total(order_id)
    order = get_order(order_id)
    order.total
  end

  def add_product(order_id, product_id)
    order = get_order(order_id)
    order.add_product(product_id)
    order
  end

  def remove_product(order_id, product_id)
    order = get_order(order_id)
    order.remove_product(product_id)
    order
  end

  def get_order(order_id)
    Order.find(order_id)
  end

end
