FactoryBot.define do
  factory :p_group do
    kind  { 'sellable' }

    before(:create) do |p_group|
      promotion = FactoryBot.create(:promotion)
      p_group.promotion = promotion
    end

    after(:create) do |p_group|
      category = FactoryBot.create(:category)
      product = FactoryBot.create(:product, category: category)
      variants = FactoryBot.create_list(:variant, 5, product: product)
      p_group.variants << variants
    end
  end
end
