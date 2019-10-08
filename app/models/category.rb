class Category < ApplicationRecord
  has_many :products
  has_one :discount

  validates :name, :status, presence: true

  enum status: { active: 'active', inactive: 'inactive' }

  scope :active_ones, -> { where(status: 'active') }
  scope :inactive_ones, -> { where(status: 'inactive') }

  before_update :change_products_status, if: :status_changed?

  def change_products_status
    return products.each(&:active!) if active?

    products.each(&:inactive!)
  end
end
