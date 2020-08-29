require 'rails_helper'

RSpec.feature 'Authentication feature specs', type: :feature do
  scenario 'Attempted login by an unregistered user' do
    visit '/sign_in'

    fill_in 'username', with: 'Name'
    click_button 'Log In'

    expect(page).not_to have_text('successfully')
  end

  scenario 'where a registered user logs in successfully' do
    visit '/sign_up'

    fill_in 'username', with: 'Name'
    click_button 'Register'

    visit '/sign_in'

    fill_in 'username', with: 'Name'
    click_button 'Log In'

    expect(page).to have_text('successfully logged in')
  end

  scenario 'successful logout' do
    visit '/sign_up'
    expect(page).to have_content('Sign Up')
    fill_in 'username', with: 'Marylene'
    click_on 'Register'
    visit '/sign_in'
    fill_in 'username', with: 'Marylene'
    click_on 'Log In'
    click_on 'Sign Out'
    expect(page).to have_content('You have successfully logged out')
  end
end

RSpec.feature 'Registration of User feature specs', type: :feature do
  scenario 'Name too short for sign up' do
    visit sign_up_path
    fill_in 'username', with: 'A'
    click_on 'Register'
    expect(page).to have_content('Name is too short (minimum is 2 characters)')
  end

  scenario 'Name not Unique Invalid Sign Up' do
    visit '/sign_up'
    expect(page).to have_content('Sign Up')
    fill_in 'username', with: 'Marylene'
    click_on 'Register'
    visit '/sign_up'
    expect(page).to have_content('Sign Up')
    fill_in 'username', with: 'Marylene'
    click_on 'Register'
    expect(page).to have_content('Name has already been taken')
  end
end
