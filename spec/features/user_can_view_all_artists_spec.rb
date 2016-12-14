require 'rails_helper'

RSpec.feature "User can view Artist List" do
  scenario "clicking on artist's name will show artist details'" do
    artist1 = Artist.create(name: "Trumpet Player", image_path: "http://www.talkshoe.com/custom/images/icons/TC-33534-MainIcon.jpg")

    visit "/artists"

    # click_on "Trumpet Player"
    click_on "#{artist1.name}"

    expect(page).to have_content(artist1.name)
    expect(page).to have_css("img[src=\"#{artist1.image_path}\"]")

  end
  scenario "artist name and image path listed in table format" do
    artist1 = Artist.create(name: "Trumpet Player", image_path: "http://www.talkshoe.com/custom/images/icons/TC-33534-MainIcon.jpg")
    artist2 = Artist.create(name: "Prince Imitator", image_path: "https://images-na.ssl-images-amazon.com/images/I/31D3WoRHC-L._AC_UL320_SR218,320_.jpg")

    visit "/artists"

    expect(page).to have_content(artist1.name)
    expect(page).to have_content(artist1.image_path)
    expect(page).to have_content(artist2.name)
    expect(page).to have_content(artist2.image_path)
  end
end