# == Schema Information
#
# Table name: shippings
#
#  id         :bigint           not null, primary key
#  value      :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  distance   :string
#
class Shipping < ApplicationRecord
  validates :value, :distance, presence: true

  enum distance: { 'inside_range': 'inside_range', '3km': '3km'}
end
