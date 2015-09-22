require 'spec_helper'
require 'rails_helper'
include AuthHelper

feature "the signup process" do
  scenario "has a new user page" do
    visit new_user_url
    expect(page).to have_content("Sign Up")
  end

  feature "signing up a user" do
    given(:user) { build(:user) }
    scenario "shows username on the homepage after signup" do
      signup_user(user)
      expect(current_path).to eq(goals_path)
    end
  end
end

feature "logging in" do
  given(:user) { create(:user) }
  scenario "shows username on the homepage after login" do
    login_user(user)
    expect(current_path).to eq(goals_path)
    expect(page).to have_content("Welcome, #{user.username}")
  end
end

feature "logging out" do
  given(:user) { create(:user) }
  scenario "begins with logged out state" do
    visit goals_url
    expect(current_path).to eq(new_session_path)
  end

  scenario "doesn't show username on the homepage after logout" do
    visit new_session_url
    fill_in "Username", with: user.username
    fill_in "Password", with: user.password
    click_button "Log In"
    click_button "Log Out"
    expect(current_path).to eq(new_session_path)
    expect(page).to_not have_content("#{user.username}")
  end
end
