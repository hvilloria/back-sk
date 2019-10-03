class Variant < ApplicationRecord
  belongs_to :product

  validates :price, :product, :status, presence: true
  validates :base, inclusion: { in: [true, false] }
  validates :name, presence: true, if: proc { |v| !v.base }
  validates :name, absence: true, if: proc { |v| v.base }

  enum status: { active: 'active', inactive: 'inactive' }

  scope :active_ones, -> { where(status: 'active') }
  scope :inactive_ones, -> { where(status: 'inactive') }
end
