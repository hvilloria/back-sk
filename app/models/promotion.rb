# == Schema Information
#
# Table name: promotions
#
#  id         :bigint           not null, primary key
#  status     :string           default("inactive"), not null
#  from_date  :datetime         default(Tue, 29 Sep 2020 18:00:00 -03 -03:00), not null
#  to_date    :datetime         default(Thu, 31 Dec 2020 20:50:00 -03 -03:00), not null
#  frequency  :string           not null, is an Array
#  kind       :string           default("price"), not null
#  value      :float
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Promotion < ApplicationRecord
  has_many :p_groups, dependent: :destroy
  has_many :variants, through: :p_groups

  accepts_nested_attributes_for :p_groups

  validates :status, :from_date, :to_date, :frequency, :kind, presence: true

  enum kind: { percentage: 'percentage', price: 'price' }
  enum status: { active: 'active', inactive: 'inactive' }

  scope :active_ones, -> { where(status: 'active') }
end
