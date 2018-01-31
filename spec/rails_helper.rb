require 'spec_helper'
require 'shoulda/matchers'
require 'webmock/rspec'
require 'simplecov'

ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)

abort('The Rails environment is running in production mode!') if Rails.env.production?

require 'rspec/rails'

ActiveRecord::Migration.maintain_test_schema!

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[Rails.root.join('spec/support/**/*.rb')].each(&method(:require))

WebMock.disable_net_connect!(allow_localhost: true)

RSpec.configure do |config|
  config.use_transactional_fixtures = true

  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!

  config.before :suite do
    DatabaseCleaner.clean_with(:truncation)

    DatabaseCleaner.strategy = :transaction
  end

  config.before(:each) { DatabaseCleaner.start }
  config.after(:each)  { DatabaseCleaner.clean }

  config.include FactoryBot::Syntax::Methods

  config.include RequestHelpers, type: :request

  config.include Shoulda::Matchers::ActiveModel,  type: :model
  config.include Shoulda::Matchers::ActiveRecord, type: :model

  config.include WebMock::API
  config.include WebMock::Matchers
end
