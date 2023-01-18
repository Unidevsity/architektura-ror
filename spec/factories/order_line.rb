FactoryBot.define do
  factory :order_line do
    order
    product
    quantity { 1 }
  end
end
