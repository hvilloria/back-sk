FactoryBot.define do
  factory :order_detail do
    association :variant
    price { variant.price }
    variant_id { variant_id }
  end
end
