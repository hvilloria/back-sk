FactoryBot.define do
  factory :product do
    name  { Faker::Food.sushi }
    status { 'active' }
    association :category
  end
end
