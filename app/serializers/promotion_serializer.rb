class PromotionSerializer < ActiveModel::Serializer
  attributes :id, :kind, :from_date, :to_date,
             :base_price, :percentage, :frequency,
             :status, :groups

  def groups
    ActiveModel::SerializableResource.new(object.p_groups, each_serializer: PGroupSerializer)
  end
end
