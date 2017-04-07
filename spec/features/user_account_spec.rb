feature 'register' do
  scenario 'user input email and password to register' do
    visit '/user/new' # New user
    fill_in(:email, with: 'unicorn@rainbows.com')
    fill_in(:password, with: 'Un!corn')
    expect {click_button('Submit')}.to change(User, :count).by(1) # Count, the method.
    expect(current_path).to eq '/links' # Go back to links.
    expect(page).to have_content 'Welcome to bookmark manager unicorn@rainbows.com' # Have the email.
  end


    # scenario 'password confirmation' do
    #   visit '/user/new'
    #   fill_in(:email, with 'unicorn@rainbows.com')
    #   fill_in(:password, with: 'Un!corn')
    #   fill_in(:password_confirmation, with: 'Unicorn')
    #   expect {click_button('Submit')}.to change(User, :count).by(1)
    #
    # end

end
