FactoryBot.define do
  factory :order do
    status { "pending" }
    order_lines { [] }
  end
end
