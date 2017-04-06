feature 'register' do
  scenario 'user input email and password to register' do
    visit '/user/new'
    fill_in(:email, with: 'unicorn@rainbows.com')
    fill_in(:password, with: 'Un!corn')
    expect {click_button('Submit')}.to change(User, :count).by(1)
    expect(current_path).to eq '/links'
    expect(page).to have_content 'Welcome to bookmark manager unicorn@rainbows.com'
  end
end
