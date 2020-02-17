FactoryBot.define do
  factory :order do
    service_type { :dl }
    notes { 'Sin jengibre ni soja' }
    total { Faker::Number.decimal(l_digits: 3, r_digits: 2) }
    client_name { Faker::Name.name }
    client_phone_number { Faker::Number.number(digits: 10) }

    before(:create) do |order|
      create(:category)
      product = FactoryBot.create(:product, category: Category.last)
      order.variants << FactoryBot.create(:variant, product: product)
      order.shipping_cost = create(:shipping)
    end
  end
end
