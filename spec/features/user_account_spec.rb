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
    expect(page).to have_content 'Password does not match the confirmation'
  end

  scenario "I can't sign up without an email address" do
    expect {sign_up(email: nil)}.to change(User, :count).by(0)
    expect(current_path).to eq '/user'
    expect(page).to have_content('Email must not be blank')
  end

  scenario "I can't sign up with an invalid email address" do
    expect {sign_up(email: "invalid@email")}.not_to change(User, :count)
    expect(current_path).to eq '/user'
    expect(page).to have_content('Email has an invalid format')
  end

  scenario "I cannot sign up with an existing email" do
    sign_up
    expect { sign_up }.to change(User, :count).by(0)
    expect(page).to have_content('Email is already taken')
  end
end
