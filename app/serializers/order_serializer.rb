class OrderSerializer < ActiveModel::Serializer
  attributes :tracking_id, :service_type, :shipping_cost,
             :total, :notes, :created_at, :payment_type,
             :client_name, :client_phone_number, :products,
             :address, :id

  def products
    object.order_details.map do |od|
      {
        name: "#{od.variant.product.name} #{od.variant.name}",
        price: od.price
      }
    end
  end

  def created_at
    object.created_at.strftime('%A, %d %B %Y, %H:%M')
  end
end
