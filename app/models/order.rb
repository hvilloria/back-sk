class Order < ApplicationRecord
  has_and_belongs_to_many :variants

  validates :variants, :service_type, :total, :payment_type, :client_name,
            :client_phone_number, presence: true

  enum service_type: { dl: 'local delivery', tk: 'take away' }
  enum payment_type: { cash: 'cash', online: 'online' }

  def self.today_ones
    orders = order(created_at: :desc)
    orders.select { |order| order.created_at.today? }
  end

  def self.deliverys
    dl.today_ones
  end

  def self.take_aways
    tk.today_ones
  end

  before_create :set_tracking_id
  before_create :set_shipping_cost, if: :dl?

  def set_tracking_id
    self.tracking_id = TrackingIdGenerator.new.start
  end

  def set_shipping_cost
    self.shipping_cost = Shipping.last.value
  end
end
