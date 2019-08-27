class Category < ApplicationRecord
  validates :name, :status, presence: true

  enum status: { available: 'available', disabled: 'disabled' }
end
