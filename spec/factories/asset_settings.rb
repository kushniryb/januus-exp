FactoryBot.define do
  factory :asset_settings, class: Hash do
    controller_name Faker::Superhero.name
    action_name     Faker::Superhero.name
    asset_type      ActionSpecificAssets::AssetType::JAVASCRIPT
    optional        Faker::Types.hash
    silence         Faker::Boolean.boolean

    trait :stylesheet do
      asset_type ActionSpecificAssets::AssetType::STYLESHEET
    end

    trait :default do
      optional Hash[:'data-turbolinks-track', 'reload']
      silence  false
    end

    trait :default_stylesheet do
      asset_type ActionSpecificAssets::AssetType::STYLESHEET
      optional   { { 'data-turbolinks-track': 'reload', media: 'all' } }
      silence    false
    end

    initialize_with { attributes }
  end
end
