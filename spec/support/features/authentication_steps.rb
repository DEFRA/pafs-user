# frozen_string_literal: true

module Features
  module AuthenticationSteps
    def login_as(user, password: "Secr3tP@ssw0rd")
      visit "/"

      expect(page).to have_selector("h1", text: "Sign in")

      fill_in "Email address", with: user.email
      fill_in "Password", with: password
      click_on "Sign in"

      expect(page).to have_selector("h1", text: "Your proposals")
    end
  end
end
