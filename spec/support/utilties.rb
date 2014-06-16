include ApplicationHelper

def valid_signin(user)
  fill_in "Email",    with: user.email
  fill_in "Password", with: user.password
  click_button "Sign in"
end

def new_form_user(user)
  fill_in "First name", with: user.first_name
  fill_in "Last name",  with: user.last_name
  fill_in "Email",      with: user.email
  fill_in "Password",   with: user.password
  fill_in "Confirm Password", with: user.password_confirmation
end
