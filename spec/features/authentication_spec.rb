# frozen_string_literal: true

RSpec.describe "Authentication" do
  context "with an invalid password" do
    let(:user) { create(:account_user, :ea) }

    it "I cannot log into my account" do
      visit "/"

      expect(page).to have_selector("h1", text: "Sign in")

      fill_in "Email address", with: user.email
      fill_in "Password", with: "invalid"
      click_on "Sign in"

      expect(page).to have_selector("h1", text: "Sign in")
    end
  end

  context "with an invalid email" do
    let(:user) { create(:account_user, :ea) }

    it "I cannot log into my account" do
      visit "/"

      expect(page).to have_selector("h1", text: "Sign in")

      fill_in "Email address", with: "invalid@example.com"
      fill_in "Password", with: "Secr3tP@ssw0rd"
      click_on "Sign in"

      expect(page).to have_selector("h1", text: "Sign in")
    end
  end

  context "with an ea user" do
    let(:user) { create(:account_user, :ea) }

    it "I can log in and see my dashboard" do
      login_as(user)
    end
  end

  context "with a PSO" do
    let(:user) { create(:account_user, :pso) }

    it "I can log in and see my dashboard" do
      login_as(user)
    end
  end

  context "with an rma" do
    let(:user) { create(:account_user, :rma) }

    it "I can log in and see my dashboard" do
      login_as(user)
    end
  end
end
