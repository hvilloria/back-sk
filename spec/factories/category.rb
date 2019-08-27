FactoryBot.define do
  factory :category do
    name   { Faker::Dessert.variety }
    status { 'available' }
  end
end
