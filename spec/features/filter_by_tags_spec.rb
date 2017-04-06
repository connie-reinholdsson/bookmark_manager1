feature 'filter by tags' do
  scenario 'filter links by specified tag' do
    visit '/links/new'
    fill_in(:name, with: 'any example')
    fill_in(:url, with: 'example.com')
    fill_in(:tags, with: 'exampletag')
    click_button('Submit')
    expect(current_path).to eq '/links'
    visit '/links/exampletag'
    expect(page).to have_content 'example.com'
  end
end
