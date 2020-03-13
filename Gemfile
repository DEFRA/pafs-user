# frozen_string_literal: true

source "https://rubygems.org"

gem "rails", "~> 4.2.11.1"
# rake 11 can break stuff see: http://stackoverflow.com/questions/35893584/nomethoderror-undefined-method-last-comment-after-upgrading-to-rake-11/35893941
gem "rake", "< 13.0"
gem "sass-rails", "~> 5.0"
gem "uglifier", ">= 1.3.0"
gem "coffee-rails", "~> 4.1.0"
gem "therubyracer", platforms: :ruby

gem "font-awesome-sass", "~> 4.5.0"
gem "jquery-rails"
gem "jquery-turbolinks"

gem "jbuilder", "~> 2.0"
gem "sdoc", "~> 0.4.0", group: :doc

gem "pg", "~> 0.20.0"
gem "dotenv-rails"

gem "devise",           "~> 4.7.1"
gem "devise_invitable", "~> 1.7.5"
gem "devise_security_extension",
  git: "https://github.com/phatworx/devise_security_extension",
  branch: "master"

gem "kaminari"

gem "dibble", "~> 0.1",
  git: "https://github.com/tonyheadford/dibble",
  branch: "develop"

# Provided by GDS - Template gives us a master layout into which
# we can inject our content using yield and content_for
gem "govuk_template", "~> 0.17.0"
# Access to some of the most common styles and scripts used by GDS
gem "govuk_frontend_toolkit", "~> 4.10.0"
# A gem wrapper around http://github.com/alphagov/govuk_elements that pulls
# stylesheet and javascript files into a Rails app.
gem "govuk_elements_rails"

# active job backend
gem "sucker_punch", "~> 2.0"

# static pages
gem "high_voltage", "~> 2.4.0"
gem "passenger", "~> 5.1", require: false
gem "whenever", require: false

# shared PAFS code
gem "pafs_core", "~> 0.0",
  git: "https://github.com/DEFRA/pafs_core",
  branch: 'develop'

group :development, :test do
  gem "rspec-rails"
  gem "byebug"
  gem "pry"
  gem "guard-rspec", require: false
end

group :development do
  gem "web-console", "~> 2.0"
  gem "letter_opener"
  gem "spring"
  gem "overcommit"
end

group :test do
  gem "factory_bot_rails", "~> 4.0"
  gem "shoulda-matchers", "~> 3.1"
  gem "faker"
  gem "capybara"
  gem "database_cleaner"
  gem "simplecov", require: false
  gem "codeclimate-test-reporter", "~> 0.6", require: false
  gem "climate_control"
end

group :production, :edge, :qa, :staging do
  gem "rails_12factor"
  gem "airbrake", "~> 5.0"
end

group :benchmark do
  gem "benchmark-ips"
  gem "ruby-prof"
  gem "stackprof"
  gem "rbtrace"
end
