class Discount < ApplicationRecord
  belongs_to :category
  belongs_to :product

  validates :amount, presence: true
end
