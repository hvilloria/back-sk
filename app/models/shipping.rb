class Shipping < ApplicationRecord
  belongs_to :category
  belongs_to :product

  validates :value, presence: true
end
