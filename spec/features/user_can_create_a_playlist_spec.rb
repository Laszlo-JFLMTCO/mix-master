require 'rails_helper'

RSpec.feature "User can create a playlist" do
  scenario "Through the add playlist from the index page" do
    new_playlist_title = "List Name"
    song1 = Song.create(title: "Song1 Title")
    song2 = Song.create(title: "Song2 Title")

    visit "/playlists"
    click_on "Add Playlist"

    fill_in "playlist[title]", with: new_playlist_title
    check("songlist[#{song2.id}]")

    click_on "Save Playlist"

    expect(page).to have_content(new_playlist_title)
    
    click_on "#{new_playlist_title}"
    expect(page).not_to have_content(song1.title)
    expect(page).to have_content(song2.title)
  end
end