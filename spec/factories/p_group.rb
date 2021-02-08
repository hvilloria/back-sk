FactoryBot.define do
  factory :p_group do
    association :promotion
    association :variant
  end
end
