feature 'filter by tags' do
  scenario 'filter links by specified tag' do
    visit '/links/new' # Go to new links.
    fill_in(:name, with: 'any example') # Put in name.
    fill_in(:url, with: 'example.com') # Put in URL.
    fill_in(:tags, with: 'exampletag') # Put in tags.
    click_button('Submit') #
    expect(current_path).to eq '/links' # Take it back.
    visit '/links/exampletag' 
    expect(page).to have_content 'example.com'
  end
end
