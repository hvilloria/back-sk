# == Schema Information
#
# Table name: orders
#
#  id                  :bigint           not null, primary key
#  tracking_id         :string
#  service_type        :string
#  shipping_cost       :integer          default(0)
#  total               :float
#  notes               :text
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  payment_type        :string           default("cash"), not null
#  client_name         :string
#  client_phone_number :string
#  address             :string
#
class Order < ApplicationRecord
  has_many :order_details, inverse_of: :order, dependent: :destroy
  accepts_nested_attributes_for :order_details

  validates :service_type, :total, :payment_type, :client_name,
            :client_phone_number, presence: true

  enum service_type: { dl: 'local delivery', tk: 'take away' }
  enum payment_type: { cash: 'cash', online: 'online' }

  def self.today_ones
    orders = order(created_at: :desc)
    orders.select { |order| order.created_at.today? }
  end

  before_create :sum_shipping, if: proc { |order| !order.shipping_cost.zero? }
  before_create :set_tracking_id

  def set_tracking_id
    self.tracking_id = TrackingIdGenerator.new.start
  end

  def sum_shipping
    self.total += shipping_cost
  end
end
