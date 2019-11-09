class Order < ApplicationRecord
  has_and_belongs_to_many :variants

  validates :variants, :service_type, :total, :payment_type, :client_name,
            :client_phone_number, presence: true

  enum service_type: { dl: 'local delivery', tk: 'take away', py: 'pedidos ya' }
  enum payment_type: { cash: 'cash', occ: 'online credit card',
                       odc: 'online debit card', lcc: 'local credit card',
                       ldc: 'local debit card' }

  def self.today_ones
    orders = order(created_at: :desc)
    orders.select { |order| order.created_at.today? }
  end

  before_create :set_tracking_id, unless: :py?
  before_create :set_shipping_cost, if: :dl?

  include AASM

  def set_tracking_id
    self.tracking_id = TrackingIdGenerator.new.start
  end

  def set_shipping_cost
    self.shipping_cost = Shipping.last.value
  end

  aasm column: 'state' do
    state :created, initial: true
    state :finished, :canceled

    event :finish do
      transitions from: :created, to: :finished
    end

    event :cancel do
      transitions from: :created, to: :canceled
    end
  end
end
