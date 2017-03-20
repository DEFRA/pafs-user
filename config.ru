# Play nice with Ruby 3 (and rubocop)
# frozen_string_literal: true

# This file is used by Rack-based servers to start the application.
require ::File.expand_path("../config/environment", __FILE__)
run Rails.application

use SecureHeaders::Middleware
