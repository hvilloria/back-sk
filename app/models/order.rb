class Order < ApplicationRecord
  belongs_to :client, class_name: 'User'
  has_and_belongs_to_many :products

  validates :client, :products, :service_type, :total, presence: true

  enum service_type: { dl: 'local delivery', tk: 'take away', py: 'pedidos ya' }

  scope :today_ones, -> { select { |order| order.created_at.today? } }

  before_create :set_tracking_id, unless: :py?
  before_create :set_shipping_cost, if: :dl?

  def set_tracking_id
    self.tracking_id = TrackingIdGenerator.new.start
  end

  def set_shipping_cost
    self.shipping_cost = Shipping.last.value
  end
end
