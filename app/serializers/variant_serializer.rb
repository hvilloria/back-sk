class VariantSerializer < ActiveModel::Serializer
  attributes :id, :name, :price, :base, :status
end
