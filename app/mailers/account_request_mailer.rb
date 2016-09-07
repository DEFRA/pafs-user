# frozen_string_literal: true
class AccountRequestMailer < ApplicationMailer
  def confirmation_email(email, name)
    @email = email
    @name = name
    mail(to: email, subject: "We've received your request to create an account")
  end

  def account_created_email(user)
    @email = user.email
    @name = user.full_name
    # NOTE: :raw_invitation_token is only available on the instance that generated
    # the token and is not persisted in the DB, so the user passed in needs to be
    # the instance created by #invite!
    @invitation_link = accept_user_invitation_url(
      invitation_token: user.raw_invitation_token)
    mail(to: user.email, subject: "Create a password for your new account "\
                                  "on the Flood and Coastal Erosion Risk "\
                                  "Management Project Application and Funding Service")
  end
end
