# == Schema Information
#
# Table name: order_details
#
#  id         :bigint           not null, primary key
#  price      :float
#  order_id   :bigint
#  variant_id :bigint
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class OrderDetail < ApplicationRecord
  belongs_to :order
  belongs_to :variant

  validates_with PriceValidator
end
