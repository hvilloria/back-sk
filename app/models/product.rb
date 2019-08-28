class Product < ApplicationRecord
  belongs_to :category

  validates :name, :price, presence: true

  scope :active_ones, -> { where(status: 'active') }
  scope :inactive_ones, -> { where(status: 'inactive') }
end
