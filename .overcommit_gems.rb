# Play nice with Ruby 3 (and rubocop)
# frozen_string_literal: true
## This file is used when running "overcommit --run" (e.g. via CircleCI or JenkinsCI)
## The related lockfile for this Gemfile is .overcommit_gems.rb.lock)
## To install gems for this Gemfile:
##   BUNDLE_GEMFILE=.overcommit_gems.rb bundle install
##   BUNDLE_GEMFILE=.overcommit_gems.rb bundle exec overcommit --install
##   BUNDLE_GEMFILE=.overcommit_gems.rb bundle exec overcommit --sign
##   BUNDLE_GEMFILE=.overcommit_gems.rb bundle exec overcommit --sign pre-commit
## To update gems in this Gemfile:
##   BUNDLE_GEMFILE=.overcommit_gems.rb bundle update
## To use this Gemfile with overcommit:
##   BUNDLE_GEMFILE=.overcommit_gems.rb bundle exec overcommit --run
## When you make a change to the overcommit configuration
##   BUNDLE_GEMFILE=.overcommit_gems.rb bundle exec overcommit --sign

## Overcommit also utilises several node packages.
## These will need to be installed independently, as follows:
##   sudo npm install -g nodejs-legacy jshint coffeelint htmlhint csslint

source "https://rubygems.org"
ruby "2.3.0"

gem "brakeman"
gem "overcommit"
gem "rubocop"
gem "scss_lint"
gem "i18n-tasks"
