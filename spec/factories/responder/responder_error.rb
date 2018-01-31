FactoryBot.define do
  factory :responder_error, class: Hash do
    title  Faker::WorldOfWarcraft.hero
    detail Faker::WorldOfWarcraft.quote

    trait :with_status do
      status Rack::Utils::HTTP_STATUS_CODES.keys.sample
    end

    trait :empty do
      title  ''
      detail ''
      status Responder::Errors::Constants::SERVER_ERROR_CODE
    end

    initialize_with { attributes }
  end
end
