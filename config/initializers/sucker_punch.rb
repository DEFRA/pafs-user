# frozen_string_literal: true

require "sucker_punch/async_syntax"

if defined?(Airbrake) # && secrets.airbrake_host.present?
  SuckerPunch.exception_handler = ->(ex, _klass, _args) { Airbrake.notify(ex) }
end
