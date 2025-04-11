# frozen_string_literal: true

RSpec.describe "Policy Page Traversal" do
  context "when a user visits the cookie or privacy policy pages" do
    let(:user) { create(:account_user, :ea) }

    it "I cannot see the navigation bar when I visit cookies policy page" do
      visit "/cookies"

      aggregate_failures do
        expect(page).to have_css("h1", text: "Cookies on Project Application and Funding Service")
        expect(page).to have_no_css("user-bar")
      end
    end

    it "I cannot see the navigation bar when I visit privacy policy page" do
      visit "pages/privacy_notice"

      aggregate_failures do
        expect(page).to have_css("h1", text: "Project Application and Funding Service Privacy Notice")
        expect(page).to have_no_css("user-bar")
      end
    end
  end
end
