class Promotion < ApplicationRecord
  has_many :p_groups, dependent: :destroy

  accepts_nested_attributes_for :p_groups

  validates :status, :from_date, :to_date, :frequency, :kind, presence: true

  enum kind: { two_for_one: 'two_for_one', percentage: 'percentage', base_price: 'base_price', gift: 'gift' }
  enum status: { active: 'active', inactive: 'inactive' }

  scope :active_ones, -> { where(status: 'active') }
end
