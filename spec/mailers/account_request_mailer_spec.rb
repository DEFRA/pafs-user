# frozen_string_literal: true

require "rails_helper"

RSpec.describe AccountRequestMailer do
  describe "#confirmation_email" do
    let(:account_request) { create(:account_request) }
    let(:email) { described_class.confirmation_email(account_request) }

    it "creates an email to the expected recipient" do
      expect(email.to).to eq(["neville.southall@example.com"])
    end

    it "creates an email from the expected sender" do
      expect(email.from).to eq([ENV.fetch("DEVISE_MAILER_SENDER")])
    end

    it "creates an email with the expected encoding" do
      expect(email.body.encoded).to match("Hello Big Nev")
    end
  end

  describe "#account_created_email" do
    let(:user) { create(:account_user) }
    let(:email) { described_class.account_created_email(user) }

    it "creates an email to the expected recipient" do
      expect(email.to).to eq(["ray@example.com"])
    end

    it "creates an email from the expected sender" do
      expect(email.from).to eq([ENV.fetch("DEVISE_MAILER_SENDER")])
    end

    it "creates an email with the expected encoding" do
      expect(email.body.encoded).to match("Hello Ray Clemence")
    end
  end
end
