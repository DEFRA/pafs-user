# frozen_string_literal: true

RSpec.describe "Authentication" do
  context "with an invalid password" do
    let(:user) { create(:account_user, :ea) }

    it "I cannot log into my account" do
      visit "/"

      fill_in "Email address", with: user.email
      fill_in "Password", with: "invalid"
      click_on "Sign in"

      expect(page).to have_css("h1", text: "Sign in")
    end
  end

  context "with an invalid email" do
    let(:user) { create(:account_user, :ea) }

    it "I cannot log into my account" do
      visit "/"

      fill_in "Email address", with: "invalid@example.com"
      fill_in "Password", with: "Secr3tP@ssw0rd"
      click_on "Sign in"

      expect(page).to have_css("h1", text: "Sign in")
    end
  end

  context "with an ea user" do
    it_behaves_like "login as", :ea
  end

  context "with a PSO" do
    it_behaves_like "login as", :pso
  end

  context "with an rma" do
    it_behaves_like "login as", :rma
  end
end
