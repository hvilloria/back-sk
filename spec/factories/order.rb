FactoryBot.define do
  factory :order do
    service_type { :dl }
    notes { 'Sin jengibre ni soja' }
    total { 1312 }

    trait :pedidos_ya_service do
      tracking_id { '3321' }
      service_type { :py }
    end

    before(:create) do |order|
      create(:category)
      order.products << FactoryBot.create(:product, category: Category.last)
      order.shipping_cost = create(:shipping)
      order.client = create(:user)
    end
  end
end
