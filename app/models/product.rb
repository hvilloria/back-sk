class Product < ApplicationRecord
  belongs_to :category

  validates :name, :price, :status, presence: true

  enum status: { active: 'active', inactive: 'active' }
end
