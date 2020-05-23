FactoryBot.define do
  factory :order_detail do
    variant
    price { variant.price }
  end
end
