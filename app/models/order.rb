class Order < ApplicationRecord
  has_and_belongs_to_many :products

  validates :products, :service_type, :total, :payment_type,
            presence: true

  enum service_type: { dl: 'local delivery', tk: 'take away', py: 'pedidos ya' }
  enum payment_type: { cash: 'cash', occ: 'online credit card',
                       odc: 'online debit card', lcc: 'local credit card',
                       ldc: 'local debit card' }

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
