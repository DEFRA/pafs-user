# Play nice with Ruby 3 (and rubocop)
# frozen_string_literal: true
PafsCore::AptNotificationMailer.class_eval do
  default from: ENV.fetch("DEVISE_MAILER_SENDER")
  layout ->(_) { "mailer" }
end
