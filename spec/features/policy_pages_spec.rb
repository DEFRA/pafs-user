# frozen_string_literal: true

RSpec.describe "Policy Page Traversal" do
  context "when a user visits the cookie or privacy policy pages" do
    let(:user) { create(:account_user, :ea) }

    it "I cannot see the navigation bar when I visit cookies policy page" do
      visit "/cookies"

      expect(page).not_to have_selector("user-bar")
    end

    it "I cannot see the navigation bar when I visit privacy policy page" do
      visit "pages/privacy_notice"

      expect(page).not_to have_selector("user-bar")
    end
  end
end
