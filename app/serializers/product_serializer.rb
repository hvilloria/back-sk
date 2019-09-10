class ProductSerializer < ActiveModel::Serializer
  attributes :name, :status

  has_many :variants
end
