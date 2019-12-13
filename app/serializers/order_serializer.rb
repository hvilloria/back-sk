class OrderSerializer < ActiveModel::Serializer
  attributes :tracking_id, :service_type, :shipping_cost,
             :total, :notes, :created_at, :payment_type,
             :client_name, :client_phone_number, :products,
             :state, :id

  def products
    object.variants.map do |variant|
      {
        name: "#{variant.product.name} #{variant.name}",
        price: variant.price
      }
    end
  end

  def created_at
    object.created_at.strftime('%A, %d %B %Y, %H:%M')
  end
end
