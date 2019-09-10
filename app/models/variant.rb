class Variant < ApplicationRecord
  belongs_to :product

  validates :price, :product, presence: true
  validates :base, inclusion: { in: [true, false] }
  validates :name, presence: true, if: proc { |v| !v.base }
  validates :name, absence: true, if: proc { |v| v.base }
end
