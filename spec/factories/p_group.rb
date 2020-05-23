FactoryBot.define do
  factory :p_group do
    kind  { 'sellable' }

    before(:create) do |p_group|
      promotion = FactoryBot.create(:promotion)
      p_group.promotion = promotion
    end

    after(:create) do |p_group|
      category = FactoryBot.create(:category)
      products = FactoryBot.create_list(:product, 5, category: category)
      p_group.products << products
    end
  end
end
