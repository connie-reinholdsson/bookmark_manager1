def sign_up(email: 'alice@example.com', password: 'Poodle', password_confirmation: 'Poodle')
  visit '/user/new' # New user
  fill_in(:email, with: email)
  fill_in(:password, with: password)
  fill_in(:password_confirmation, with: password_confirmation)
  click_button 'Submit'
end
