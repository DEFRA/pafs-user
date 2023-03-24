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

RSpec.shared_examples "can do" do |action, selectors|
  it "I can #{action} the project" do
    selectors.each do |sel|
      expect(page).to have_selector("a", text: sel)
    end
  end
end

RSpec.shared_examples "cannot do" do |action, selectors, selector_class|
  it "I cannot #{action} the project" do
    selectors.each do |sel|
      expect(page).not_to have_selector(selector_class, text: sel)
    end
  end
end

RSpec.shared_examples "viewing a project" do |spec|
  context "with a #{spec[:user_type]} user" do
    let(:user) { create(:account_user, spec[:user_type]) }

    before do
      login_as(user)
    end

    context "with a #{spec[:project_state]} project for a #{spec[:project_area]}" do
      let(:project) { create(:full_project, spec[:project_state]) }
      let(:area) { create(spec[:project_area]) }

      before do
        project.area_projects.create(area: area)
        user.user_areas.create(area: area)
        user.save!

        view_a_project(project)
      end

      it_behaves_like spec[:can_edit] ? "can do" : "cannot do", "edit", %w[Change Add], "a"

      if spec[:can_change_state]
        if spec[:project_state] == :archived
          it_behaves_like "cannot do", "submit", %w[Submit], "a"
          it_behaves_like "can do", "revert", ["Revert to draft"], "a"
        end

        if spec[:project_state] == :draft
          it_behaves_like "can do", "submit", %w[Submit], "a"
          it_behaves_like "can do", "archive", %w[Archive], ".project-overview-head a"
        end

        if spec[:project_state] == :submitted # rubocop:disable Style/IfUnlessModifier
          it_behaves_like "can do", "revert", ["Revert to draft"], "a"
        end
      else
        it_behaves_like "cannot do", "submit", %w[Submit], "a"
        it_behaves_like "cannot do", "revert", ["Revert to draft"], "a"
        it_behaves_like "cannot do", "archive", %w[Archive], ".project-overview-head a"
      end
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
