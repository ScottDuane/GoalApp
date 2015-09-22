require 'spec_helper'
require 'rails_helper'
include AuthHelper

feature "Creating New Goals" do
  given(:user) { create(:user) }
  given!(:goal) { create(:goal) }

  scenario "Creating goal shows goal on user's goals page" do
    login_user(user)
    click_on "New Goal"
    expect(current_path).to eq(new_goal_path)
    fill_in "Description", with: goal.description
    click_on "Create Goal"
    expect(current_path).to eq(goals_path)
    expect(page).to have_content(goal.description)
  end

  scenario "Validates description is not blank" do
    login_user(user)
    visit new_goal_url
    click_on "Create Goal"
    expect(page).to have_content("Description can't be blank")
  end
end

feature "Updating goals" do
  given(:user) { create(:user) }
  given!(:goal) { create(:goal) }

  scenario "Updating goals updates goal on user's page" do
    # goal
    login_user(user)
    click_on "Edit"
    expect(current_path).to eq(edit_goal_path(goal))
    new_description = Faker::Hacker.say_something_smart
    fill_in "Description", with: new_description
    click_on "Update"
    expect(page).to have_content(new_description)
  end
end

feature "Deleting goals" do
  given(:user) { create(:user) }
  given!(:goal) { create(:goal) }

  scenario "Deleting goal removes it from user's page" do
    login_user(user)
    click_on "Delete"
    expect(page).to_not have_content(goal.description)
  end

  scenario "Default complete value is 'In Progress'" do
    login_user(user)
    expect(page).to have_content('In Progress')
  end

  scenario "Goal status changes on update" do
    login_user(user)
    click_on "Edit"
    select "Complete", from: 'completeness'
    click_on "Update"
    expect(page).to have_content('Complete')
  end
end
