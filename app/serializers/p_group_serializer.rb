class PGroupSerializer < ActiveModel::Serializer
  attributes :id, :kind, :products

  def products
    object.variants.map do |variant|
      {
        name: "#{variant.product.name} #{variant.name}",
        price: variant.price
      }
    end
  end
end
