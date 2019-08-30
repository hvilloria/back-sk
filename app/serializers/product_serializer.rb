class ProductSerializer < ActiveModel::Serializer
  attributes :name, :price, :presentation, :status
end
