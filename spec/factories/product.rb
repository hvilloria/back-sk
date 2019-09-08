FactoryBot.define do
  factory :product do
    name  { Faker::Food.sushi }
    presentation { 15 }
  end
end
