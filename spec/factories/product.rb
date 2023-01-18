# product factory

FactoryBot.define do
  factory :product do
    name { Faker::Commerce.product_name }
    description { Faker::Lorem.paragraph }
    price_cents { Random.rand(10000) }
  end
end
