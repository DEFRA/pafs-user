# frozen_string_literal: true

class PafsMailer < Devise::Mailer
  include PafsCore::Email
  add_template_helper(PafsCore::EmailHelper)
  include Devise::Controllers::UrlHelpers
  layout "mailer"
  default template_path: "devise/mailer"

  def confirmation_instructions(record, token, opts = {})
    prevent_tracking
    super
  end

  def reset_password_instructions(record, token, opts = {})
    prevent_tracking
    super
  end

  def unlock_instructions(record, token, opts = {})
    prevent_tracking
    super
  end

  def password_change(record, opts = {})
    prevent_tracking
    super
  end
end
