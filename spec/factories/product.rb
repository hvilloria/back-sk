FactoryBot.define do
  factory :product do
    name  { Faker::Food.sushi }
  end
end
