# frozen_string_literal: true
# Preview all emails at http://localhost:3000/rails/mailers/account_request_mailer
class AccountRequestMailerPreview < ActionMailer::Preview
  def confirmation_email
    AccountRequestMailer.confirmation_email("ray.clemence@example.com", "Ray Clemence")
  end

  def account_created_email
    u = User.first
    AccountRequestMailer.account_created_email(u)
  end
end
