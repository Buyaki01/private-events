require "rails_helper"

RSpec.feature "Authentication feature specs", :type => :feature do
  scenario "Attempted login by an unregistered user" do
    visit "/sign_in"

    fill_in "username", :with => "Name"
    click_button "Submit"

    expect(page).not_to have_text("successfully")
  end

  scenario "where a registered user logs in successfully" do
    visit "/sign_up"

    fill_in "username", :with => "Name"
    click_button "Submit"

    visit "/sign_in"

    fill_in "username", :with => "Name"
    click_button "Submit"

    expect(page).to have_text("successfully logged in")
  end
end