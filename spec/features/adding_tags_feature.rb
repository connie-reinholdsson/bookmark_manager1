feature 'inputting tags' do
  scenario 'let user add tags to links' do
    visit '/links/new'
    fill_in(:name, with: 'Makers Academy')
    fill_in(:url, with: 'http://www.makersacademy.com')
    fill_in(:tags, with: 'coding')
    click_button 'Submit'
    expect(page).to have_content('coding')
    # link = Link.first
    # expect(link.tags.map(&:name)).to include('coding')
  end

  scenario 'let user add multiple tags' do
    visit '/links/new'
    fill_in(:name, with: 'Tea and kittens')
    fill_in(:url, with: 'www.teaandkittens.com')
    fill_in(:tags, with: 'tea, kittens, kitty')
    click_button 'Submit'
    link = Link.first
    expect(link.tags.map(&:name)).to include('tea')
    expect(link.tags.map(&:name)).to include('kittens')
  end
end
