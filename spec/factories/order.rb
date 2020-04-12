FactoryBot.define do
  factory :order do
    service_type { :dl }
    notes { 'Sin jengibre ni soja' }
    total { Faker::Number.decimal(l_digits: 3, r_digits: 2) }
    client_name { Faker::Name.name }
    client_phone_number { Faker::Number.number(digits: 10) }
  end
end
