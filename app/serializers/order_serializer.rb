class OrderSerializer < ActiveModel::Serializer
  attributes :tracking_id, :service_type, :shipping_cost,
             :total, :notes, :created_at, :payment_type
  has_many :products
end
