class PGroup < ApplicationRecord
  belongs_to :promotion
  has_and_belongs_to_many :products

  validates :promotion, :kind, presence: true

  enum kind: { sellable: 'sellable', giftable: 'giftable' }
end
