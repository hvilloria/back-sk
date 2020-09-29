# == Schema Information
#
# Table name: p_groups
#
#  id           :bigint           not null, primary key
#  promotion_id :bigint
#  variant_id   :bigint
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
class PGroup < ApplicationRecord
  belongs_to :promotion
  belongs_to :variant
end
