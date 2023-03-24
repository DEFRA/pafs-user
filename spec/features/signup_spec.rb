# frozen_string_literal: true

RSpec.describe "Signup" do
  context "with a valid invitation" do
    let!(:user) { create(:account_user, :pso, :invited, raw_invitation_token: "INVITATION") }

    before do
      visit "/users/invitation/accept?invitation_token=INVITATION"

      fill_in "Password", with: "Password123!"
      fill_in "Confirm password", with: "Password123!"
      click_on "Create password"
    end

    it "I can set my password" do
      expect(page).to have_selector("h1", text: "Your proposals")
    end

    it "after signing out I can sign in again" do
      click_on "Sign out"
      expect(page).to have_selector("h1", text: "Sign in")

      login_as(user, password: "Password123!")
    end
  end

  context "with an invalid invitation" do
    it "I am sent to the sign in screen" do
      visit "/users/invitation/accept?invitation_token=INVALID"
      expect(page).to have_selector("h1", text: "Sign in")
    end
  end
end
