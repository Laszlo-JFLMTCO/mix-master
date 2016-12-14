require 'rails_helper'

RSpec.feature "User can view artist's song list'" do
  scenario "After adding new song" do
    artist1 = Artist.create(name: "Trumpet Player", image_path: "http://www.talkshoe.com/custom/images/icons/TC-33534-MainIcon.jpg")
    song_title = "Test Song Title"

    visit "/artists"
    click_on "#{artist1.name}"

    click_on "Add Song"

    fill_in "song[title]", with: song_title
    click_on "Save Song"

    click_on "Artist Details"

    expect(page).to have_content(song_title)
    expect(page).to have_content("Artist Details")
  end
end