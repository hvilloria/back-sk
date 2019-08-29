class Category < ApplicationRecord
  has_many :products
  has_one :discount

  validates :name, :status, presence: true

  enum status: { available: 'available', disabled: 'disabled' }
end
