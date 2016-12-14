require 'rails_helper'

RSpec.feature "User can view playlist collection" do
  scenario "Through index page" do
    playlist = Playlist.create(title: "List Name", linklist_id: 1)
    song = Song.create(title: "Song Name", linklist_id: 1)
    Linklist.create(song_id: 1, playlist_id: 1)

    visit "/playlists"

    expect(page).to have_content(playlist.title)
  end
end