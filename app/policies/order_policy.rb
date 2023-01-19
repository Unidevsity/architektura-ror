class OrderPolicy
  def can_be_closed?(order)
    order.status == 'completed' && order.total > 100 && order.order_lines.first.product.price > 100
  end

end
