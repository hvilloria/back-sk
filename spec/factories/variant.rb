FactoryBot.define do
  factory :variant do
    name  { Faker::Name.name }
    price { Faker::Number.within(range: 200..1000) }
    base { false }
    status { 'active' }
    association :product
  end

  trait :base_variant do
    name  { '' }
    price { Faker::Number.within(range: 200..1000) }
    base { true }
  end
end
