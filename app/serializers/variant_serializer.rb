class VariantSerializer < ActiveModel::Serializer
  attributes :name, :price, :base, :status
end
