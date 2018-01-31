FactoryBot.define do
  factory :address do
    address  { Faker::Address.street_address }
    state    { Faker::Address.state_abbr }
    city     { Faker::Address.city }
    zip_code { Faker::Address.zip_code }

    excavator
  end
end
