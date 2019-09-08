class OrderSerializer < ActiveModel::Serializer
  attributes :tracking_id, :service_type,
             :shipping_cost, :total, :notes, :products
  belongs_to :client

  def client
    object.client.name
  end
end
