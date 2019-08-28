class Category < ApplicationRecord
  has_many :products
  has_many :shippings

  validates :name, :status, presence: true

  enum status: { available: 'available', disabled: 'disabled' }
end
