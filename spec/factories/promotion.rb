FactoryBot.define do
  factory :promotion do
    status { 'active' }
    from_date { Time.zone.now }
    to_date { Time.zone.now + 10.days }
    frequency { %w[Tuesday Friday] }
    kind { 'percentage' }
    value { Faker::Number.within(range: 1..99) }
  end
end
