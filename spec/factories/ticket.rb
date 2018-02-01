FactoryBot.define do
  factory :ticket do
    request_id               { Faker::Code.imei }
    sequence_id              { Faker::Number.number(4).to_i }
    request_type             { Ticket.request_types.values.sample }
    service_area             { Faker::Hipster.word }
    additional_service_areas { Faker::Hipster.words(4) }
    response_due_at          { Faker::Time.between(5.days.ago, 1.year.from_now) }

    trait :with_locations do
      locations { PolygonGenerator.random_polygon }
    end

    trait :with_excavator do
      excavator
    end
  end
end
