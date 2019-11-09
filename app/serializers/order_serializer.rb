class OrderSerializer < ActiveModel::Serializer
  attributes :tracking_id, :service_type, :shipping_cost,
             :total, :notes, :created_at, :payment_type,
             :client_name, :client_phone_number, :products,
             :state

  def products
    object.variants.map do |variant|
      {
        name: "#{variant.product.name} #{variant.name}",
        price: variant.price
      }
    end
  end
end
