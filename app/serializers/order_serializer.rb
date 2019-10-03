class OrderSerializer < ActiveModel::Serializer
  attributes :tracking_id, :service_type, :shipping_cost,
             :total, :notes, :created_at, :payment_type
  belongs_to :client
  has_many :products

  def client
    object.client.name
  end
end
