class CategorySerializer < ActiveModel::Serializer
  attributes :name, :status
  has_many :products
end
