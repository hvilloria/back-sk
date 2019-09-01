class Order < ApplicationRecord
  belongs_to :client, class_name: 'User'
  has_and_belongs_to_many :products

  enum service_type: { dl: 'delivery local', tk: 'take away', py: 'pedidos ya' }

  validates :client, :products, :service_type, :total, presence: true

  before_create :set_tracking_id if :service_is_tk?

  before_create :set_shipping_cost if :service_is_dl?

  def service_is_tk?
    tk?
  end

  def service_is_dl?
    dl?
  end

  def set_tracking_id
    tracking_id = TrackingIdGenerator.new.start
  end

  def set_shipping_cost
    shipping_cost = Shipping.last.value
  end
end
