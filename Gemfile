source "https://rubygems.org"

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem "rails", '7.2.2.2'
# The original asset pipeline for Rails [https://github.com/rails/sprockets-rails]
gem "sprockets-rails"
# Use postgresql as the database for Active Record
gem "pg", "~> 1.1"
# Use the Puma web server [https://github.com/puma/puma]
gem 'rack', '2.2.17'
gem 'puma', '6.6.1'
# Use JavaScript with ESM import maps [https://github.com/rails/importmap-rails]
gem "importmap-rails"
# Hotwire's SPA-like page accelerator [https://turbo.hotwired.dev]
gem "turbo-rails"
# Hotwire's modest JavaScript framework [https://stimulus.hotwired.dev]
gem "stimulus-rails"
# Build JSON APIs with ease [https://github.com/rails/jbuilder]
gem "jbuilder"

# Use Kredis to get higher-level data types in Redis [https://github.com/rails/kredis]
# gem "kredis"

# Use Active Model has_secure_password [https://guides.rubyonrails.org/active_model_basics.html#securepassword]
# gem "bcrypt", "~> 3.1.7"

# Gems for searching using Elasticsearch server
gem 'searchkick', '5.5.2'
gem 'elasticsearch', '7.17.11'

# Gems for Tailwind CSS
gem 'tailwindcss-ruby', '3.4.17'
gem 'tailwindcss-rails', '3.3.2'

# Gems to parse HTML and Scrapper
gem 'watir', '7.3.0'

# Gem to encrypt urls
gem 'tinyurl_shortener'

# Gem to icons
gem 'font-awesome-sass', '6.7.2'

gem 'simple_form', '5.3.1'

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: %i[ windows jruby ]

# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", require: false

# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
# gem "image_processing", "~> 1.2"

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem "debug", platforms: %i[ mri windows ], require: "debug/prelude"

  # Static analysis for security vulnerabilities [https://brakemanscanner.org/]
  gem "brakeman", require: false

  # Omakase Ruby styling [https://github.com/rails/rubocop-rails-omakase/]
  gem "rubocop-rails-omakase", require: false
  # Use for testing
  gem "rspec-rails"
  gem "vcr", require: false
  gem "webmock"
  gem "shoulda-matchers"
  # Use for creating factories
  gem "factory_bot_rails"
  # Use for creating fake data
  gem "faker"
  gem "rails-controller-testing"
end

group :development do
  # Use console on exceptions pages [https://github.com/rails/web-console]
  gem "web-console"
end

group :test do
  # Use system testing [https://guides.rubyonrails.org/testing.html#system-testing]
  gem "capybara", '3.40.0'
  gem "selenium-webdriver", '4.30.1'
end