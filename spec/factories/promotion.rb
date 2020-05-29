FactoryBot.define do
  factory :promotion do
    status { 'active' }
    from_date { DateTime.now }
    to_date { DateTime.now + 10.days }
    frequency { ['tuesday', 'friday'] }
    kind { 'percentage' }
    percentage { Faker::Number.within(range: 1..99) }
  end
end
