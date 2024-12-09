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

group :development, :test do
  gem "debug"
  gem "brakeman", require: false
  gem "rubocop-rails-omakase", require: false
  gem "rspec-rails", "~> 6.0"
  gem "factory_bot_rails"
  gem "faker"
  gem "byebug"
end

group :test do
end
