source "https://rubygems.org"

gem 'rails', '~> 7.1', '>= 7.1.3.2'
gem "propshaft"
gem "pg", "~> 1.1"
gem "puma", ">= 5.0"
gem "jsbundling-rails"
gem "cssbundling-rails"
gem "jbuilder"
gem 'devise', '~> 4.9', '>= 4.9.4'
gem "tzinfo-data", platforms: %i[ windows jruby ]
gem "solid_cache"
gem "solid_queue"
gem "solid_cable"
gem "bootsnap", require: false
gem "kamal", require: false
gem "thruster", require: false

group :development, :test do
  gem "debug", platforms: %i[ mri windows ], require: "debug/prelude"
  gem "brakeman", require: false
  gem "rubocop-rails-omakase", require: false
  gem 'rspec-rails', '~> 6.0'
end

group :development do
  gem "web-console"
  gem 'byebug', '~> 11.1', '>= 11.1.3'
end

group :test do
  gem 'factory_bot_rails'
  gem 'shoulda-matchers', '~> 6.4'
  gem 'database_cleaner-active_record'
  gem 'simplecov', require: false
  gem 'rails-controller-testing', '~> 1.0', '>= 1.0.5'
end
