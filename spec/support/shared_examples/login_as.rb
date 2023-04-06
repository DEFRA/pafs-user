# frozen_string_literal: true

RSpec.shared_examples "login as" do |user_type, password|
  let(:user) { create(:account_user, user_type) }

  password ||= "Secr3tP@ssw0rd"

  before { visit "/" }

  it "has a sign in header" do
    expect(page).to have_selector("h1", text: "Sign in")
  end

  it "signs in successfully" do
    fill_in "Email address", with: user.email
    fill_in "Password", with: password
    click_on "Sign in"

    expect(page).to have_selector("h1", text: "Your proposals")
  end
end
