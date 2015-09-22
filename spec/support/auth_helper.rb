module AuthHelper
  def signup_user(user)
    visit new_user_url
    fill_in "Username", with: user.username
    fill_in "Password", with: user.password
    click_button "Sign Up"
  end

  def login_user(user)
    visit new_session_url
    fill_in "Username", with: user.username
    fill_in "Password", with: user.password
    click_button "Log In"
  end
end
