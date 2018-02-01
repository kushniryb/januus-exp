FactoryBot.define do
  factory :excavator do
    company_name { Faker::Company.name }
    manned       { Faker::Boolean.boolean }

    ticket
  end
end
