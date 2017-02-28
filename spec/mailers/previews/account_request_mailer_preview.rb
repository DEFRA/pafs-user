# frozen_string_literal: true
# Preview all emails at http://localhost:3000/rails/mailers/account_request_mailer
class AccountRequestMailerPreview < ActionMailer::Preview
  def confirmation_email
    AccountRequestMailer.confirmation_email(PafsCore::AccountRequest.last)
  end

  def new_account_request
    AccountRequestMailer.new_account_request(PafsCore::AccountRequest.last)
  end

  def account_created_email
    u = User.first
    AccountRequestMailer.account_created_email(u)
  end
end
