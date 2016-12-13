require 'rails_helper'

RSpec.feature "User can view Artist List" do
  scenario "clicking on artist's name will show artist details'" do
    artist_name1 = "Trumpet Player"
    artist_image_path1 = "http://www.talkshoe.com/custom/images/icons/TC-33534-MainIcon.jpg"
    artist1 = Artist.create(artist_name: artist_name1, artist_image_path: artist_image_path1)

    within ".table" do
      click_link "#{artist_name1}"
    end

    save_and_open_page
    expect(page).to have_content(artist_name1)
    expect(page).to have_css("img[src=\"#{artist_image_path1}\"]")

  end
  scenario "artist name and image path listed in table format" do
    artist1 = Artist.create(artist_name: "Trumpet Player", artist_image_path: "http://www.talkshoe.com/custom/images/icons/TC-33534-MainIcon.jpg")
    artist2 = Artist.create(artist_name: "Prince Imitator", artist_image_path: "https://images-na.ssl-images-amazon.com/images/I/31D3WoRHC-L._AC_UL320_SR218,320_.jpg")

    expect(page).to have_content(artist1.artist_image_path)
    expect(page).to have_css("img[src=\"#{artist_image_path1}\"]")
  end
end