# frozen_string_literal: true

source "https://rubygems.org"
ruby "3.1.2"

gem "coffee-rails"
gem "rails", "6.1.7"
gem "rake"
gem "sass-rails"
gem "uglifier"

gem "font-awesome-sass", "~> 4.7.0"
gem "jquery-rails"
gem "jquery-turbolinks"

gem "jbuilder"
gem "sdoc"

gem "dotenv-rails"
gem "pg"

gem "devise"
gem "devise_invitable"
gem "devise-security"

gem "faraday-retry"

gem "kaminari"

gem "dibble", "~> 0.1",
    git: "https://github.com/tonyheadford/dibble",
    branch: "develop"

gem "govuk_elements_rails"
gem "govuk_frontend_toolkit"
gem "govuk_publishing_components"
gem "govuk_template"

# active job backend
gem "sucker_punch", "~> 2.0"

# static pages
gem "high_voltage"
gem "passenger", "~> 5.1", require: false
gem "whenever", require: false

# shared PAFS code
gem "pafs_core",
    git: "https://github.com/DEFRA/pafs_core",
    branch: "main"

gem "github_changelog_generator", require: false

group :development, :test do
  gem "byebug"
  gem "defra_ruby_style", "~> 0.3"
  gem "pry"
  gem "rspec-rails"
  gem "rubocop"
  gem "rubocop-rails"
  gem "rubocop-rake"
  gem "rubocop-rspec"
end

group :development do
  gem "letter_opener"
  gem "spring"
  gem "web-console"
end

group :test do
  gem "capybara"
  gem "climate_control"
  gem "database_cleaner"
  gem "factory_bot_rails"
  gem "faker"
  gem "shoulda-matchers"
  gem "simplecov", require: false
end

group :production, :edge, :qa, :staging do
  gem "rails_12factor"
end

group :benchmark do
  gem "benchmark-ips"
  gem "rbtrace"
  gem "ruby-prof"
  gem "stackprof"
end
