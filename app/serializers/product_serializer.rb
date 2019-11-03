class ProductSerializer < ActiveModel::Serializer
  attributes :id, :name, :status

  has_many :variants
end
