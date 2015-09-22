require 'spec_helper'
require 'rails_helper'
include AuthHelper

feature "Commenting on goals" do
  given!(:user1) { create(:user) }
  given!(:user2) { create(:user) }
  given!(:goal) { create(:goal) }
  given!(:goal_comment) { create(:goal_comment) }

  scenario "New comments appear on goal page" do
    login_user(user2)
    visit goal_url(goal)
    expect(page).to have_content(goal_comment.body)
  end

  scenario "User can add comments on another user's goals page" do
    login_user(user2)
    visit goal_url(goal)
    comment = Faker::Hacker.say_something_smart
    fill_in "Body", with: comment
    expect(page).to have_content(comment)
  end

  scenario "User can delete comments on their goals" do
    login_user(user1)
    visit goal_url(goal)
    click_on "Delete"
    expect(page).to_not have_content(goal_comment.body)
  end

  scenario "User can delete a comment they made" do
    login_user(user2)
    visit goal_url(goal)
    click_on "Delete"
    expect(page).to_not have_content(goal_comment.body)
  end

end

feature "Commenting on users" do
  given!(:user1) { create(:user) }
  given!(:user2) { create(:user) }
  given!(:user_comment) { create(:user_comment) }

  scenario "Comments on a user's show page are visible" do
    login_user(user2)
    visit user_url(user1)
    expect(page).to have_content(user_comment.body)
  end

  scenario "Users can add comments on other users" do
    login_user(user1)
    visit user_url(user2)
    comment_text = Faker::Hacker.say_something_smart
    fill_in "Comment", with: comment_text
    click_on "Add Comment"
    expect(page).to have_content(comment_text)
  end

  scenario "User can delete comments on their page" do
    login_user(user1)
    visit user_url(user1)
    click_on "Delete Comment"
    expect(page).to_not have_content(user_comment.body)
  end

  scenario "User can delete a comment they wrote" do
    login_user(user2)
    visit user_url(user1)
    click_on "Delete Comment"
    expect(page).to_not have_content(user_comment.body)
  end
  
end
