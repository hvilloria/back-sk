class ProductSerializer < ActiveModel::Serializer
  attributes :name, :presentation, :status
end
