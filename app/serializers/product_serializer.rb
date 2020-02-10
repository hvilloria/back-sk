class ProductSerializer < ActiveModel::Serializer
  attributes :id, :name, :status, :variants

  def variants
    ActiveModelSerializers::SerializableResource.new(object.variants)
  end
end
