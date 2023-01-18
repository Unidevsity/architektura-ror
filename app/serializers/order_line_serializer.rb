class OrderLineSerializer < ActiveModel::Serializer
  attributes :id, :quantity, :product_id
end
