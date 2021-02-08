class PromotionSerializer < ActiveModel::Serializer
  attributes :id, :kind, :from_date, :to_date,
             :value, :frequency,
             :status, :products

  def products
    object.variants.map do |variant|
      {
        id: variant.id,
        name: "#{variant.product.name} #{variant.name}",
        price: variant.price
      }
    end
  end
end
