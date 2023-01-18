FactoryBot.define do
  factory :order_line do
    product
    quantity { 1 }
  end
end
