# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Cookies" do
  describe "POST /fo/cookies/accept_analytics" do
    it "accepts analytics cookies and redirects" do
      post accept_analytics_cookies_path

      expect(response).to redirect_to("/")
      expect(cookies[:cookies_policy]).to eq("analytics_accepted")
    end
  end

  describe "POST /fo/cookies/reject_analytics" do
    it "rejects analytics cookies and redirects" do
      post reject_analytics_cookies_path

      expect(response).to redirect_to("/")
      expect(cookies[:cookies_policy]).to eq("analytics_rejected")
    end
  end

  describe "POST /fo/cookies/hide_this_message" do
    it "records that cookie preferences have been set" do
      post hide_this_message_cookies_path

      expect(response).to redirect_to("/")
      expect(cookies[:cookies_preferences_set]).to be_truthy
    end
  end

  describe "PATCH /fo/cookies" do
    context "when accepting analytics" do
      it "updates the cookies policy and preferences" do
        patch cookies_path, params: { analytics: "accept" }

        expect(response).to redirect_to(edit_cookies_path(cookies_updated: true))
        expect(cookies[:cookies_policy]).to eq("analytics_accepted")
        expect(cookies[:cookies_preferences_set]).to be_truthy
      end
    end

    context "when rejecting analytics" do
      it "updates the cookies policy and preferences" do
        patch cookies_path, params: { analytics: "reject" }

        expect(response).to redirect_to(edit_cookies_path(cookies_updated: true))
        expect(cookies[:cookies_policy]).to eq("analytics_rejected")
        expect(cookies[:cookies_preferences_set]).to be_truthy
      end
    end
  end
end
