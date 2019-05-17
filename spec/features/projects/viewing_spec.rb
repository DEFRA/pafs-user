# frozen_string_literal: true

RSpec.feature 'Viewing a project', type: :feature do
  context 'without FORCE_PSO_TO_POL set' do
    context 'as an rma user' do
      let(:user) { create(:account_user, :rma) }

      before do
        login_as(user)
      end

      context 'with a draft project for an rma area' do
        let(:project) { create(:full_project) }

        before do
          project.area_projects.create(area: user.primary_area)
        end

        scenario 'I can submit the project' do
          view_a_project(project)

          expect(page).to have_selector('a', text: 'Submit')
        end

        scenario 'I can archive the project' do
          view_a_project(project)

          expect(page).to have_selector('.project-overview-head a', text: 'Archive')
        end
      end

      context 'with an archived project for an rma area' do
        let(:project) { create(:full_project, :archived) }

        before do
          project.area_projects.create(area: user.primary_area)
        end

        scenario 'I cannot submit the project' do
          view_a_project(project)

          expect(page).not_to have_selector('a', text: 'Submit')
        end

        scenario 'I can un-archive the project' do
          view_a_project(project)

          expect(page).to have_selector('a', text: 'Revert to draft')
        end
      end
    end

    context 'as a pso user' do
      let(:user) { create(:account_user, :pso) }

      before do
        login_as(user)
      end

      context 'with a draft project for a pso area' do
        let(:project) { create(:full_project) }

        before do
          project.area_projects.create(area: user.primary_area)
        end

        scenario 'I can submit the project' do
          view_a_project(project)

          expect(page).to have_selector('a', text: 'Submit')
        end

        scenario 'I can archive the project' do
          view_a_project(project)

          expect(page).to have_selector('.project-overview-head a', text: 'Archive')
        end
      end

      context 'with an archived project for an rma area' do
        let(:project) { create(:full_project, :archived) }

        before do
          project.area_projects.create(area: user.primary_area)
        end

        scenario 'I cannot submit the project' do
          view_a_project(project)

          expect(page).not_to have_selector('a', text: 'Submit')
        end

        scenario 'I can un-archive the project' do
          view_a_project(project)

          expect(page).to have_selector('a', text: 'Revert to draft')
        end
      end
    end
  end

  context 'with FORCE_PSO_TO_POL set' do
    before do
      allow(ENV).to receive(:fetch).with('FORCE_PSO_TO_POL', false).and_return(true)
    end

    context 'as an rma user' do
      let(:user) { create(:account_user, :rma) }

      before do
        login_as(user)
      end

      context 'with a draft project for an rma area' do
        let(:project) { create(:full_project) }

        before do
          project.area_projects.create(area: user.primary_area)
        end

        scenario 'I can submit the project' do
          view_a_project(project)

          expect(page).to have_selector('a', text: 'Submit')
        end

        scenario 'I can archive the project' do
          view_a_project(project)

          expect(page).to have_selector('.project-overview-head a', text: 'Archive')
        end
      end

      context 'with a draft project for an pso area' do
        let(:project) { create(:full_project) }
        let(:pso_area) { create(:pso_area) }

        before do
          user.user_areas.create(area: pso_area)
          project.area_projects.create(area: pso_area)
        end

        scenario 'I cannot submit the project' do
          view_a_project(project)

          expect(page).not_to have_selector('a', text: 'Submit')
        end

        scenario 'I cannot archive the project' do
          view_a_project(project)

          expect(page).not_to have_selector('.project-overview-head a', text: 'Archive')
        end
      end

      context 'with an archived project for an rma area' do
        let(:project) { create(:full_project, :archived) }

        before do
          project.area_projects.create(area: user.primary_area)
        end

        scenario 'I cannot submit the project' do
          view_a_project(project)

          expect(page).not_to have_selector('a', text: 'Submit')
        end

        scenario 'I can un-archive the project' do
          view_a_project(project)

          expect(page).to have_selector('a', text: 'Revert to draft')
        end
      end
    end

    context 'as a pso user' do
      let(:user) { create(:account_user, :pso) }

      before do
        login_as(user)
      end

      context 'with a draft project for a pso area' do
        let(:project) { create(:full_project) }

        before do
          project.area_projects.create(area: user.primary_area)
        end

        scenario 'I cannot submit the project' do
          view_a_project(project)

          expect(page).not_to have_selector('a', text: 'Submit')
        end

        scenario 'I can archive the project' do
          view_a_project(project)

          expect(page).not_to have_selector('.project-overview-head a', text: 'Archive')
        end
      end

      context 'with an archived project for an rma area' do
        let(:project) { create(:full_project, :archived) }

        before do
          project.area_projects.create(area: user.primary_area)
        end

        scenario 'I cannot submit the project' do
          view_a_project(project)

          expect(page).not_to have_selector('a', text: 'Submit')
        end

        scenario 'I cannot un-archive the project' do
          view_a_project(project)

          expect(page).not_to have_selector('a', text: 'Revert to draft')
        end
      end
    end
  end
end
