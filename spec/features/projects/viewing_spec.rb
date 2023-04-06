# frozen_string_literal: true

FLAG_DISABLED_SPECS = [
  { user_type: :rma, project_area: :pso_area, project_state: :draft,     can_change_state: true,  can_edit: true },
  { user_type: :rma, project_area: :rma_area, project_state: :draft,     can_change_state: true,  can_edit: true },
  { user_type: :rma, project_area: :pso_area, project_state: :submitted, can_change_state: false, can_edit: false },
  { user_type: :rma, project_area: :rma_area, project_state: :submitted, can_change_state: false, can_edit: false },
  { user_type: :rma, project_area: :pso_area, project_state: :archived,  can_change_state: true,  can_edit: false },
  { user_type: :rma, project_area: :rma_area, project_state: :archived,  can_change_state: true,  can_edit: false },
  { user_type: :pso, project_area: :pso_area, project_state: :draft,     can_change_state: true,  can_edit: true },
  { user_type: :pso, project_area: :rma_area, project_state: :draft,     can_change_state: true,  can_edit: true },
  { user_type: :pso, project_area: :pso_area, project_state: :submitted, can_change_state: false,  can_edit: false },
  { user_type: :pso, project_area: :rma_area, project_state: :submitted, can_change_state: false,  can_edit: false },
  { user_type: :pso, project_area: :pso_area, project_state: :archived,  can_change_state: true,  can_edit: false },
  { user_type: :pso, project_area: :rma_area, project_state: :archived,  can_change_state: true,  can_edit: false }
].freeze

FLAG_ENABLED_SPECS = [
  { user_type: :rma, project_area: :pso_area, project_state: :draft,     can_change_state: false, can_edit: false },
  { user_type: :rma, project_area: :rma_area, project_state: :draft,     can_change_state: true,  can_edit: true },
  { user_type: :rma, project_area: :pso_area, project_state: :submitted, can_change_state: false, can_edit: false },
  { user_type: :rma, project_area: :rma_area, project_state: :submitted, can_change_state: false, can_edit: false },
  { user_type: :rma, project_area: :pso_area, project_state: :archived,  can_change_state: false, can_edit: false },
  { user_type: :rma, project_area: :rma_area, project_state: :archived,  can_change_state: true,  can_edit: false },
  { user_type: :pso, project_area: :pso_area, project_state: :draft,     can_change_state: false, can_edit: false },
  { user_type: :pso, project_area: :rma_area, project_state: :draft,     can_change_state: true,  can_edit: true },
  { user_type: :pso, project_area: :pso_area, project_state: :submitted, can_change_state: false, can_edit: false },
  { user_type: :pso, project_area: :rma_area, project_state: :submitted, can_change_state: false, can_edit: false },
  { user_type: :pso, project_area: :pso_area, project_state: :archived,  can_change_state: false, can_edit: false },
  { user_type: :pso, project_area: :rma_area, project_state: :archived,  can_change_state: true,  can_edit: false }
].freeze

RSpec::Matchers.define :have_ability_to do |action_label, selector_classes: "a"|
  match do |page|
    page.has_selector?(selector_classes, text: action_label)
  end

  failure_message do
    "expected page to have the ability to #{action_label} the project, but it does not"
  end

  failure_message_when_negated do
    "expected page not to have the ability to #{action_label} the project, but it does"
  end
end

RSpec.shared_examples "viewing a project" do |spec|
  context "with a #{spec[:user_type]} user" do
    let(:user) { create(:account_user, spec[:user_type]) }

    before { login_as(user) }

    context "with a #{spec[:project_state]} project for a #{spec[:project_area]}" do
      let(:project) { create(:full_project, spec[:project_state]) }
      let(:area) { create(spec[:project_area]) }

      before do
        project.area_projects.create(area: area)
        user.user_areas.create(area: area)
        user.save!

        view_a_project(project)
      end

      # rubocop:disable RSpec/RepeatedExample
      if spec[:can_edit]
        it { expect(page).to have_ability_to("Change") }
        it { expect(page).to have_ability_to("Add") }
      else
        it { expect(page).not_to have_ability_to("Change") }
        it { expect(page).not_to have_ability_to("Add") }
      end

      if spec[:can_change_state]
        if spec[:project_state] == :archived
          it { expect(page).not_to have_ability_to("Submit") }
          it { expect(page).to have_ability_to("Revert to draft") }
        end

        if spec[:project_state] == :draft
          it { expect(page).to have_ability_to("Submit") }
          it { expect(page).to have_ability_to("Archive", selector_classes: ".project-overview-head a") }
        end

        if spec[:project_state] == :submitted # rubocop:disable Style/IfUnlessModifier
          it { expect(page).to have_ability_to("Revert to draft") }
        end
      else
        it { expect(page).not_to have_ability_to("Submit") }
        it { expect(page).not_to have_ability_to("Revert to draft") }
        it { expect(page).not_to have_ability_to("Archive", selector_classes: ".project-overview-head a") }
      end
      # rubocop:enable RSpec/RepeatedExample
    end
  end
end

RSpec.describe "Viewing a project" do
  context "without FORCE_PSO_TO_POL set" do
    FLAG_DISABLED_SPECS.each do |spec|
      it_behaves_like "viewing a project", spec
    end
  end

  context "with FORCE_PSO_TO_POL set" do
    FLAG_ENABLED_SPECS.each do |spec|
      around do |example|
        with_modified_env FORCE_PSO_TO_POL: "1" do
          example.run
        end
      end

      it_behaves_like "viewing a project", spec
    end
  end
end
