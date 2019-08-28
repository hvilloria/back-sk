FactoryBot.define do
  factory :product do
    name   { Faker::Food.sushi }
    price  { Faker::Number.within(range: 200..1000) }
    presentation { 15 }
  end
end
