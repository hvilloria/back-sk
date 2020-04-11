# == Schema Information
#
# Table name: shippings
#
#  id         :bigint           not null, primary key
#  value      :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Shipping < ApplicationRecord
  validates :value, presence: true
end
