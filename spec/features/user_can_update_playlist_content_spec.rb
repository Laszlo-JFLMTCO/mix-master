require 'rails_helper'

RSpec.feature "User can update playlist content" do
  scenario "Through the playlist detailed view page" do
    playlist = Playlist.create(title: "List Name", linklist_id: 1)
    song1 = Song.create(title: "Song1 Title")
    playlist.songs << song1
    song2 = Song.create(title: "Song2 Title")

    visit "/playlists/#{playlist.id}"
    click_on "Edit Playlist"

    check("songlist[#{song2.id}]")
    uncheck("songlist[#{song1.id}]")

    click_on "Update Playlist"

    click_on "#{playlist.title}"
    expect(page).not_to have_content(song1.title)
    expect(page).to have_content(song2.title)

  end
end