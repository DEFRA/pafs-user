# frozen_string_literal: true

RSpec.feature 'Creating a project', type: :feature do
  context 'without FORCE_PSO_TO_POL set' do
    context 'as an rma user' do
      let(:user) { create(:account_user, :rma) }

      scenario 'it lets me bootstrap a project' do
        login_as(user)
        bootstrap_a_new_proposal(
          type: 'DEF',
          name: 'A new project',
          year: Time.now.year + 2
        )
      end
    end

    context 'as a pso user' do
      let(:user) { create(:account_user, :pso) }

      scenario 'it lets me bootstrap a project' do
        login_as(user)
        bootstrap_a_new_proposal(
          type: 'DEF',
          name: 'A new project',
          year: Time.now.year + 2
        )
      end
    end
  end

  context 'with FORCE_PSO_TO_POL set' do
    before do
      allow(ENV).to receive(:fetch).with('FORCE_PSO_TO_POL', false).and_return(true)
    end

    context 'as an rma user' do
      let(:user) { create(:account_user, :rma) }

      scenario 'it lets me bootstrap a project' do
        login_as(user)
        bootstrap_a_new_proposal(
          type: 'DEF',
          name: 'A new project',
          year: Time.now.year + 2
        )
      end
    end

    context 'as a pso user' do
      let(:user) { create(:account_user, :pso) }

      scenario 'it doesn\'t let me bootstrap a project' do
        login_as(user)

        expect(page).not_to have_text('Create a new proposal')
        expect(page).to have_text('To create a new proposal please go to PoL')
      end
    end
  end
end

