require 'rails_helper'

RSpec.describe 'Event Management Features', type: :feature do
  scenario 'home page is rendered successfully' do
    visit '/sign_up'
    fill_in 'username', with: 'Marylene'
    click_on 'Register'
    click_on 'Events'
    expect(page).to have_content(
      "Events\nUpcoming Events\nDescription Date\nPast Events\nDescription Date"
    )
  end

  scenario 'a new event is created successfully' do
    sign_in

    click_on 'New Event'
    fill_in 'event_description', with: 'Cats Event'
    fill_in 'event_date', with: Date.today
    click_on 'Create Event'
    expect(page).to have_content('Event was successfully created.')
  end

  scenario 'invalid inputs for creating an event - duplicate descriptions' do
    sign_in

    click_on 'New Event'
    fill_in 'event_description', with: 'Cats Event'
    fill_in 'event_date', with: Date.today
    click_on 'Create Event'
    click_on 'New Event'
    fill_in 'event_description', with: 'Cats Event'
    fill_in 'event_date', with: Date.today
    click_on 'Create Event'
    expect(page).not_to have_content('success')
    expect(page).to have_content('Description has already been taken')
  end

  scenario 'invalid inputs for creating an event - date omitted' do
    sign_in

    click_on 'New Event'
    fill_in 'event_description', with: 'Cats Event'
    click_on 'Create Event'
    expect(page).not_to have_content('success')
    expect(page).to have_content('Date can\'t be blank')
  end

  scenario 'invalid inputs for creating an event - description omitted' do
    sign_in

    click_on 'New Event'
    fill_in 'event_date', with: Date.today
    click_on 'Create Event'
    expect(page).not_to have_content('success')
    expect(page).to have_content('Description can\'t be blank')
  end

  scenario 'invalid inputs for creating an event - description too short' do
    sign_in

    click_on 'New Event'
    fill_in 'event_description', with: 'Ca'
    fill_in 'event_date', with: Date.today
    click_on 'Create Event'
    expect(page).to have_content('Description is too short (minimum is 3 characters)')
  end

  scenario 'a registered user attends existing events' do
    sign_in
    create_events

    click_on 'Attend Event(s)'
    page.check 'Dogs Event'
    page.check 'Cats Event'
    click_on 'Save'
    expect(page).to have_content('You have successfully registered for the chosen event(s)')
    expect(page).to have_content("Upcoming Events you have Registered for:\nCats Event Dogs Event")

    # renders page to attend events with existing events that ther user has not yet
    # registered to attend
    click_on 'Attend Event(s)'
    expect(page).to have_content('Dogs And Cats Festival')
    expect(page).to_not have_content('Persons Event')
    expect(page).to_not have_content('Dogs Event')
    expect(page).to_not have_content('Cats Event')
  end

  scenario 'a registered user cannot attend events if there are no more events to attend' do
    sign_in
    click_on 'Attend Event(s)'

    expect(page).not_to have_content('Save')
    expect(page).to have_content('You have already registered for all the available events.')
    expect(page).to have_content(
      'There are no more events to attend. Create an event to attend or wait for one to be created.'
    )
  end
end

private

def sign_in
  visit '/sign_up'
  fill_in 'username', with: 'Marylene'
  click_on 'Register'
  visit '/sign_in'
  fill_in 'username', with: 'Marylene'
  click_on 'Log In'
end

def create_events
  click_on 'New Event'
  fill_in 'event_description', with: 'Cats Event'
  fill_in 'event_date', with: Time.zone.now + 10.days
  click_on 'Create Event'

  visit new_event_path
  fill_in 'event_description', with: 'Dogs Event'
  fill_in 'event_date', with: Time.zone.now + 5.days
  click_on 'Create Event'

  visit new_event_path
  fill_in 'event_description', with: 'Dogs And Cats Festival'
  fill_in 'event_date', with: Time.zone.now + 15.days
  click_on 'Create Event'

  visit new_event_path
  fill_in 'event_description', with: 'Persons Event'
  fill_in 'event_date', with: '27/08/2020'
  click_on 'Create Event'
end
