# frozen_string_literal: true

FLAG_DISABLED_SPECS = [
  { user_type: :rma, project_area: :pso_area, project_state: :draft,    can_change_state: true, can_edit: true },
  { user_type: :rma, project_area: :rma_area, project_state: :draft,    can_change_state: true, can_edit: true },
  { user_type: :rma, project_area: :pso_area, project_state: :archived, can_change_state: true, can_edit: false},
  { user_type: :rma, project_area: :rma_area, project_state: :archived, can_change_state: true, can_edit: false },
  { user_type: :pso, project_area: :pso_area, project_state: :draft,    can_change_state: true, can_edit: true },
  { user_type: :pso, project_area: :rma_area, project_state: :draft,    can_change_state: true, can_edit: true },
  { user_type: :pso, project_area: :pso_area, project_state: :archived, can_change_state: true, can_edit: false },
  { user_type: :pso, project_area: :rma_area, project_state: :archived, can_change_state: true, can_edit: false },
]

FLAG_ENABLED_SPECS = [
  { user_type: :rma, project_area: :pso_area, project_state: :draft,    can_change_state: false, can_edit: false },
  { user_type: :rma, project_area: :rma_area, project_state: :draft,    can_change_state: true,  can_edit: true },
  { user_type: :rma, project_area: :pso_area, project_state: :archived, can_change_state: false, can_edit: false },
  { user_type: :rma, project_area: :rma_area, project_state: :archived, can_change_state: true,  can_edit: false },
  { user_type: :pso, project_area: :pso_area, project_state: :draft,    can_change_state: false, can_edit: false },
  { user_type: :pso, project_area: :rma_area, project_state: :draft,    can_change_state: true,  can_edit: true },
  { user_type: :pso, project_area: :pso_area, project_state: :archived, can_change_state: false, can_edit: false },
  { user_type: :pso, project_area: :rma_area, project_state: :archived, can_change_state: true,  can_edit: false },
]

def run_spec_configuration(spec)
  context "as a #{spec[:user_type]} user" do
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
        user.touch

        view_a_project(project)
      end

      if spec[:can_edit]
        scenario 'I can edit the project' do
          expect(page).to have_selector('a', text: 'Change')
          expect(page).to have_selector('a', text: 'Add')
        end
      else
        scenario 'I cannot edit the project' do
          expect(page).not_to have_selector('a', text: 'Change')
          expect(page).not_to have_selector('a', text: 'Add')
        end
      end

      if spec[:can_change_state]
        if spec[:project_state] == :archived
          scenario 'I cannot submit the project' do
            expect(page).not_to have_selector('a', text: 'Submit')
          end

          scenario 'I can un-archive the project' do
            expect(page).to have_selector('a', text: 'Revert to draft')
          end
        else
          scenario 'I can submit the project' do
            expect(page).to have_selector('a', text: 'Submit')
          end

          scenario 'I can archive the project' do
            expect(page).to have_selector('.project-overview-head a', text: 'Archive')
          end
        end
      else
        scenario 'I cannot submit the project' do
          expect(page).not_to have_selector('a', text: 'Submit')
        end

        scenario 'I cannot un-archive the project' do
          expect(page).not_to have_selector('a', text: 'Revert to draft')
        end

        scenario 'I cannot archive the project' do
          expect(page).not_to have_selector('.project-overview-head a', text: 'Archive')
        end
      end
    end
  end
end

RSpec.feature 'Viewing a project', type: :feature do
  context 'without FORCE_PSO_TO_POL set' do
    FLAG_DISABLED_SPECS.each do |spec|
      run_spec_configuration(spec)
    end
  end

  context 'with FORCE_PSO_TO_POL set' do
    FLAG_ENABLED_SPECS.each do |spec|
      around do |example|
        with_modified_env FORCE_PSO_TO_POL: '1' do
          example.run
        end
      end

      run_spec_configuration(spec)
    end
  end
end
