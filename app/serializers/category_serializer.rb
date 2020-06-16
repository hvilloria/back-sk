class CategorySerializer < ActiveModel::Serializer
  attributes :name, :status, :id
  has_many :products
end
