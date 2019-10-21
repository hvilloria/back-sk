class OrderSerializer < ActiveModel::Serializer
  attributes :tracking_id, :service_type, :shipping_cost,
             :total, :notes, :created_at, :payment_type,
             :client_name, :client_phone_number
  has_many :products
end
