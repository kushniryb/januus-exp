source 'https://rubygems.org'

ruby '2.4.0'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end

# === CORE ===

gem 'pg',    '~> 0.18'
gem 'puma',  '~> 3.7'
gem 'rails', '~> 5.1.0'

# === FEATURES ===

gem 'draper'
gem 'kaminari'
gem 'reform',       '~> 2.2.4'
gem 'reform-rails', '~> 0.1.7'

# === API ===

gem 'jbuilder'
gem 'oj'
gem 'rabl'

# === FRONT-END ===

gem 'foundation-rails'
gem 'hamlit'
gem 'sass-rails',  '~> 5.0'
gem 'simple_form', '~> 3.5.0'
gem 'turbolinks',  '~> 5'
gem 'uglifier',    '>= 1.3.0'

# === GROUPS ===

group :development do
  gem 'awesome_print'
  gem 'brakeman',                           require: false
  gem 'bullet'
  gem 'colorize'
  gem 'hamlit-rails'
  gem 'html2haml'
  gem 'listen',                '>= 3.0.5',  '< 3.2'
  gem 'rubocop',               '~> 0.52.1', require: false
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'web-console',           '>= 3.3.0'
end

group :test do
  gem 'database_cleaner'
  gem 'factory_bot_rails'
  gem 'faker'
  gem 'shoulda-matchers', '~> 3.1'
  gem 'simplecov'
end

group :development, :test do
  gem 'capybara'
  gem 'capybara-screenshot'
  gem 'capybara-webkit'
  gem 'pry-rails'
  gem 'rspec-rails'
  gem 'selenium-webdriver'
  gem 'webmock'
end

# === WINDOWS

gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
