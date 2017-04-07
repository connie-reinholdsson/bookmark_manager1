require_relative 'web_helpers'

feature 'register' do
  scenario 'user input email and password to register' do
    expect {sign_up}.to change(User, :count).by(1) # Count, the method.
    expect(current_path).to eq '/links' # Go back to links.
    expect(page).to have_content 'Welcome to bookmark manager alice@example.com' # Have the email.
  end

  scenario 'password confirmation' do
    expect {sign_up(password_confirmation: 'wrong')}.not_to change(User, :count)
    expect(current_path).to eq('/user')
    expect(page).to have_content 'Password and confirmation password do not match'
  end
end
