# frozen_string_literal: true

RSpec.feature 'Authentication', type: :feature do
  context 'with an invalid password' do
    let(:user) { create(:account_user, :ea) }
    
    scenario 'I cannot log into my account' do
      visit '/'

      page.should have_selector('h1', text: 'Sign in')

      fill_in 'Email address', with: user.email
      fill_in 'Password', with: 'invalid'
      click_on 'Sign in'

      page.should have_selector('h1', text: 'Sign in')
    end
  end

  context 'with an invalid email' do
    let(:user) { create(:account_user, :ea) }
    
    scenario 'I cannot log into my account' do
      visit '/'

      page.should have_selector('h1', text: 'Sign in')

      fill_in 'Email address', with: 'invalid@example.com'
      fill_in 'Password', with: 'Secr3tP@ssw0rd'
      click_on 'Sign in'

      page.should have_selector('h1', text: 'Sign in')
    end
  end

  context 'as an ea user' do
    let(:user) { create(:account_user, :ea) }

    scenario 'I can log in and see my dashboard' do
      login_as(user)
    end
  end
  
  context 'as a PSO' do
    let(:user) { create(:account_user, :pso) }

    scenario 'I can log in and see my dashboard' do
      login_as(user)
    end
  end

  context 'as an rma' do
    let(:user) { create(:account_user, :rma) }

    scenario 'I can log in and see my dashboard' do
      login_as(user)
    end
  end
end

