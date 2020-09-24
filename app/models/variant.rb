# == Schema Information
#
# Table name: variants
#
#  id          :bigint           not null, primary key
#  price       :float
#  name        :string
#  base        :boolean          not null
#  product_id  :bigint
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  status      :string           default("active"), not null
#  description :text
#
class Variant < ApplicationRecord
  belongs_to :product
  has_and_belongs_to_many :orders
  has_and_belongs_to_many :p_groups
  has_many :order_details

  validates :price, :product, :status, presence: true
  validates :base, inclusion: { in: [true, false] }
  validates :name, presence: true, if: proc { |v| !v.base }
  validates :name, absence: true, if: proc { |v| v.base }

  after_update :inactive_product

  enum status: { active: 'active', inactive: 'inactive' }

  scope :active_ones, -> { where(status: 'active') }
  scope :inactive_ones, -> { where(status: 'inactive') }

  def inactive_product
    product.inactive! if product.variants.active.empty?
  end
end
