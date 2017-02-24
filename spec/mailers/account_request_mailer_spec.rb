# frozen_string_literal: true
require "rails_helper"

RSpec.describe AccountRequestMailer, type: :mailer do
  describe "#confirmation_email" do
    it "creates an email" do
      email = AccountRequestMailer.confirmation_email("neville.southall@example.com", "Big Nev")
      expect(email.to).to eq(["neville.southall@example.com"])
      expect(email.from).to eq([ENV.fetch("DEVISE_MAILER_SENDER")])
      expect(email.body.encoded).to match("Hello Big Nev")
    end
  end

  describe "#account_created_email" do
    it "creates an email" do
      user = FactoryGirl.create(:user)
      email = AccountRequestMailer.account_created_email(user)
      expect(email.to).to eq(["ray@example.com"])
      expect(email.from).to eq([ENV.fetch("DEVISE_MAILER_SENDER")])
      expect(email.body.encoded).to match("Hello Ray Clemence")
    end
  end
end
