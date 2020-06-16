# == Schema Information
#
# Table name: discounts
#
#  id          :bigint           not null, primary key
#  amount      :integer          not null
#  category_id :bigint
#  product_id  :bigint
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class Discount < ApplicationRecord
  belongs_to :category
  belongs_to :product

  validates :amount, presence: true
end
