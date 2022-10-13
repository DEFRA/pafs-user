# Play nice with Ruby 3 (and rubocop)
# frozen_string_literal: true

class AccountRequestsController < ApplicationController
  def show
    @account_request = PafsCore::AccountRequest.find_by!(slug: params[:id])
  end

  def new
    @account_request = PafsCore::AccountRequest.new
  end

  def create
    @account_request = PafsCore::AccountRequest.new(account_params)
    if @account_request.save
      send_emails
      redirect_to @account_request
    else
      render "new"
    end
  end

  private

  def account_params
    params.require(:account_request)
          .permit(:first_name, :last_name, :email, :organisation, :job_title,
                  :telephone_number, :terms_accepted, :provisioned)
  end

  def full_name
    "#{@account_request.first_name} #{@account_request.last_name}"
  end

  def send_emails
    AccountRequestMailer.new_account_request(@account_request).deliver_later
    AccountRequestMailer.confirmation_email(@account_request).deliver_later
  end
end
