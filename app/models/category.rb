class Category < ApplicationRecord
  has_many :products

  validates :name, :status, presence: true

  enum status: { available: 'available', disabled: 'disabled' }
end
