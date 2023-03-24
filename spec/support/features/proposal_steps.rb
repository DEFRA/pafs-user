# frozen_string_literal: true

module Features
  module ProposalSteps
    def view_a_project(project)
      visit "/pc/projects/#{project.to_param}"
    end
  end
end
