# frozen_string_literal: true
class ApplicationMailer < ActionMailer::Base
  include PafsCore::Email
  add_template_helper(PafsCore::EmailHelper)
  layout "mailer"
  default from: ENV.fetch("DEVISE_MAILER_SENDER")
  layout "mailer"
end
