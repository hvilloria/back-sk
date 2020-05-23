class Promotion < ApplicationRecord
  has_many :p_groups

  validates :status, :from_date, :to_date, :frequency, :kind, presence: true

  enum kind: { two_for_one: '2x1', percentage: 'percentage', base_price: 'base_price', gift: 'gift' }
  enum status: { active: 'active', inactive: 'inactive' }

  scope :active_ones, -> { where(status: 'active') }
end
