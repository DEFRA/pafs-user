# frozen_string_literal: true

module Features
  module ProposalSteps
    PROPOSAL_TYPE = {
      "DEF" => "def",
      "Capital Maintenance" => "cm",
      "Property level protection" => "plp",
      "Bridge works" => "brg",
      "Strategies" => "str",
      "Environmental with households" => "env_with_households",
      "Environmental without households" => "env_without_households"
    }.freeze

    def view_a_project(project)
      visit "/pc/projects/#{project.to_param}"
    end

    def bootstrap_a_new_proposal(type:, name:, year:)
      go_to_new_proposal_page
      enter_the_proposal_name(name)
      select_the_proposal_type(type)
      select_the_financial_year(year)

      expect(page).to have_selector("h1", text: "Proposal overview")
    end

    def enter_the_proposal_name(name)
      expect(page).to have_selector("legend", text: "What is the project’s name?")

      fill_in "project-name-step-name-field", with: name
      click_on "Save and continue"
    end

    def select_the_proposal_type(type)
      expect(page).to have_selector("legend", text: "What type of project are you proposing?")

      type_code = PROPOSAL_TYPE[type] || raise("unrecognised proposal type")
      choose "project-type-step-project-type-#{type_code}-field"
      click_on "Save and continue"
    end

    def select_the_financial_year(year)
      expect(page).to have_selector("legend", text: "In what financial year will the project stop spending funds?")

      choose "April #{year} to March #{year + 1}"
      click_on "Save and continue"
    end

    def go_to_new_proposal_page
      visit "/"
      click_on "Create a new proposal"
    end
  end
end
