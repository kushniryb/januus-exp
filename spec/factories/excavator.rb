FactoryBot.define do
  factory :excavator do
    company_name { Faker::Company.name }
    manned       { Faker::Boolean.boolean }

    ticket

    trait :with_address do
      address
    end
  end
end
