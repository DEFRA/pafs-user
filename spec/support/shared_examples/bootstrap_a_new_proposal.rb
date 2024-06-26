# frozen_string_literal: true

RSpec.shared_examples "bootstrap a new proposal" do |user_type|

  let(:user) { create(:account_user, user_type) }
  let(:proposal_type) { "def" }
  let(:name) { "A new project" }
  let(:year) { Time.zone.now.year + 2 }

  # rubocop:disable RSpec/ExampleLength
  it "visits the proposals page" do
    login_as(user)

    visit "/"
    click_on "Create a new proposal"

    fill_in "project-name-step-name-field", with: name
    click_on "Save and continue"

    choose "project-type-step-project-type-#{proposal_type}-field"
    click_on "Save and continue"

    expect(page).to have_css("legend", text: "In what financial year will the project stop spending funds?")

    choose "April #{year} to March #{year + 1}"
    click_on "Save and continue"
  end
  # rubocop:enable RSpec/ExampleLength
end
