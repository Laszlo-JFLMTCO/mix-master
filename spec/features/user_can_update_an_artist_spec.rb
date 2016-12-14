require 'rails_helper'

RSpec.feature "User can update an artist" do
  scenario "from artist index page with unique name" do
    artist1 = Artist.create(name: "Trumpet Player", image_path: "http://www.talkshoe.com/custom/images/icons/TC-33534-MainIcon.jpg")
    updated_artist_name = "Updated Name"
    artist_image_path = "http://eng.inyarwanda.com/img/images/artist-icon.png"

    visit "/artists"
    click_on "Edit"

    fill_in "artist[name]", with: updated_artist_name
    click_on "Update Artist Info"

    expect(page).to have_content(updated_artist_name)
    expect(page).not_to have_content(artist1.name)
    expect(page).to have_css("img[src=\"#{artist1.image_path}\"]")
  end
end