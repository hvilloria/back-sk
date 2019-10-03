FactoryBot.define do
  factory :order do
    service_type { :dl }
    notes { 'Sin jengibre ni soja' }
    total { Faker::Number.decimal(l_digits: 3, r_digits: 2) }

    trait :pedidos_ya_service do
      tracking_id { '3321' }
      service_type { :py }
    end

    before(:create) do |order|
      create(:category)
      order.products << FactoryBot.create(:product, category: Category.last)
      order.shipping_cost = create(:shipping)
    end
  end
end
