FactoryBot.define do
  factory :order do
    service_type { Order.service_types.keys.sample }
    notes { 'Sin jengibre ni soja' }
    total { 1312 }
    tracking_id { TrackingIdGenerator.new.start }

    before(:create) do |order|
      create(:category)
      order.products << FactoryBot.create(:product, category: Category.last)
      order.shipping_cost = create(:shipping)
      order.client = create(:user)
    end
  end
end
