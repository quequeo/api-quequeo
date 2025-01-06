source "https://rubygems.org"

ruby "3.2.4"

gem "rails", "~> 8.0"
gem "pg", "~> 1.1"
gem "puma", ">= 5.0"
gem "bcrypt", "~> 3.1.7"
gem "tzinfo-data", platforms: %i[ windows jruby ]
gem "bootsnap", require: false
gem "rack-cors"
gem "jwt"
gem "dotenv-rails"
gem 'aws-sdk-s3', require: false
gem 'active_model_serializers'
gem 'pundit'
gem 'scout_apm'
gem 'rack-attack'

group :development, :test do
  gem "brakeman", '~> 7.0 ', require: false
  gem "rubocop-rails-omakase", require: false
  
  # RSpec
  gem "rspec-rails", "~> 6.0"
  gem "factory_bot_rails"
  gem "faker"
  gem 'database_cleaner-active_record'
  gem 'shoulda-matchers', '~> 5.0'

  # Debug
  gem "byebug"
end
