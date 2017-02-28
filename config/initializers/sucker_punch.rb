require "sucker_punch/async_syntax"

if defined?(Airbrake) #&& secrets.airbrake_host.present?
  SuckerPunch.exception_handler = ->(ex, klass, args) { Airbrake.notify(ex) }
end
