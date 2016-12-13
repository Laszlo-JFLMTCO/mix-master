require 'rails_helper'

RSpec.feature "User submits a new artist" do
  scenario "Can enter data to create a new artist" do
    artist_name = "Test Artist Name 1"
    artist_image_path = "http://eng.inyarwanda.com/img/images/artist-icon.png"

    visit "/artists"
    click_on "Add Artist"

    fill_in "artist[artist_name]", with: artist_name
    fill_in "artist[artist_image_path]", with: artist_image_path
    click_on "Create Artist"

    expect(page).to have_content(artist_name)
    expect(page).to have_css("img[src=\"#{artist_image_path}\"]")
  end
end