class CategorySerializer < ActiveModel::Serializer
  attributes :name, :status
  has_many :products

  def products
    object.products.active_ones
  end
end
