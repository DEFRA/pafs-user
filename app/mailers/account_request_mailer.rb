# frozen_string_literal: true
class AccountRequestMailer < ApplicationMailer
  include PafsCore::Email

  def confirmation_email(email, name)
    prevent_tracking
    @email = email
    @name = name
    mail(to: email, subject: "Account requested - FCERM project funding")
  end

  def account_created_email(user)
    prevent_tracking
    @email = user.email
    @name = user.full_name
    # NOTE: :raw_invitation_token is only available on the instance that generated
    # the token and is not persisted in the DB, so the user passed in needs to be
    # the instance created by #invite!
    @invitation_link = accept_user_invitation_url(
      invitation_token: user.raw_invitation_token)
    mail(to: user.email, subject: "Account created - FCERM project funding")
  end
end
