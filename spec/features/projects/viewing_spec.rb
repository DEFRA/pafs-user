# frozen_string_literal: true


FLAG_DISABLED_SPECS = [
  { user_type: :rma, project_area: :pso_area, project_state: :draft,    can_change_state: true },
  { user_type: :rma, project_area: :rma_area, project_state: :draft,    can_change_state: true },
  { user_type: :rma, project_area: :pso_area, project_state: :archived, can_change_state: true },
  { user_type: :rma, project_area: :rma_area, project_state: :archived, can_change_state: true },
  { user_type: :pso, project_area: :pso_area, project_state: :draft,    can_change_state: true },
  { user_type: :pso, project_area: :rma_area, project_state: :draft,    can_change_state: true },
  { user_type: :pso, project_area: :pso_area, project_state: :archived, can_change_state: true },
  { user_type: :pso, project_area: :rma_area, project_state: :archived, can_change_state: true },
]

FLAG_ENABLED_SPECS = [
  { user_type: :rma, project_area: :pso_area, project_state: :draft,    can_change_state: false },
  { user_type: :rma, project_area: :rma_area, project_state: :draft,    can_change_state: true },
  { user_type: :rma, project_area: :pso_area, project_state: :archived, can_change_state: false },
  { user_type: :rma, project_area: :rma_area, project_state: :archived, can_change_state: true },
  { user_type: :pso, project_area: :pso_area, project_state: :draft,    can_change_state: false },
  { user_type: :pso, project_area: :rma_area, project_state: :draft,    can_change_state: true },
  { user_type: :pso, project_area: :pso_area, project_state: :archived, can_change_state: false },
  { user_type: :pso, project_area: :rma_area, project_state: :archived, can_change_state: true },
]

RSpec.feature 'Viewing a project', type: :feature do
  context 'without FORCE_PSO_TO_POL set' do
    FLAG_DISABLED_SPECS.each do |spec|
      context "as a #{spec[:user_type]} user" do
        let(:user) { create(:account_user, spec[:user_type]) }

        before do
          login_as(user)
        end

        context "with a #{spec[:project_state]} project for a #{spec[:project_area]}" do
          let(:project) { create(:full_project) }
          let(:area) { create(spec[:project_area]) }

          before do
            project.area_projects.create(area: area)
            user.user_areas.create(area: area)
          end

          if spec[:can_change_state]
            scenario 'I cannot submit the project' do
              view_a_project(project)

              expect(page).not_to have_selector('a', text: 'Submit')
            end

            scenario 'I cannot un-archive the project' do
              view_a_project(project)

              expect(page).not_to have_selector('a', text: 'Revert to draft')
            end

            scenario 'I cannot archive the project' do
              view_a_project(project)

              expect(page).not_to have_selector('.project-overview-head a', text: 'Archive')
            end
          else
            if spec[:project_state] == :archived
              scenario 'I cannot submit the project' do
                view_a_project(project)

                expect(page).not_to have_selector('a', text: 'Submit')
              end

              scenario 'I can un-archive the project' do
                view_a_project(project)

                expect(page).to have_selector('a', text: 'Revert to draft')
              end
            else
              scenario 'I can submit the project' do
                view_a_project(project)

                expect(page).to have_selector('a', text: 'Submit')
              end

              scenario 'I can archive the project' do
                view_a_project(project)

                expect(page).to have_selector('.project-overview-head a', text: 'Archive')
              end
            end
          end
        end
      end
    end
  end
end
