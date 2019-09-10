class Product < ApplicationRecord
  belongs_to :category
  has_one :discount
  has_many :variants, dependent: :destroy
  has_and_belongs_to_many :orders

  accepts_nested_attributes_for :variants

  validates :name, :status, presence: true

  enum status: { active: 'active', inactive: 'inactive' }

  scope :active_ones, -> { where(status: 'active') }
  scope :inactive_ones, -> { where(status: 'inactive') }
end
