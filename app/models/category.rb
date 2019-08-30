class Category < ApplicationRecord
  has_many :products

  validates :name, :status, presence: true

  enum status: { active: 'active', inactive: 'inactive' }

  scope :active_ones, -> { where(status: 'active') }
  scope :inactive_ones, -> { where(status: 'inactive') }
end
