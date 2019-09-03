FactoryBot.define do
  factory :shipping do
    value { rand(30..60) }
  end
end
