FactoryBot.define do
  factory :product do
    name  { Faker::Food.sushi }
    status { 'active' }
    association :category

    factory :product_with_variant do
      after(:create) do |product|
        create(:variant, product: product)
      end
    end
  end
end
