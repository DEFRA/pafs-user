# frozen_string_literal: true

RSpec.feature 'Policy Page Traversal', type: :feature do
    context 'when a user visits the cookie or privacy policy pages' do
      let(:user) { create(:account_user, :ea) }
  
      scenario 'I cannot see the navigation bar when I visit cookies policy page' do
        visit '/cookies'
  
        expect(page).to_not have_selector('user-bar')
      end

      scenario 'I cannot see the navigation bar when I visit privacy policy page' do
        visit 'pages/pafs_privacy_policy'
  
        expect(page).to_not have_selector('user-bar')
      end
    end
  end