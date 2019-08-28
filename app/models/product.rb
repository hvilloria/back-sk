class Product < ApplicationRecord
  belongs_to :category
  has_many :shippings

  validates :name, :price, :status, presence: true

  enum status: { active: 'active', inactive: 'inactive' }
end
