RSpec.feature "user can delete an artist" do
  scenario "from the artist index page" do
    artist1 = Artist.create(name: "Trumpet Player", image_path: "http://www.talkshoe.com/custom/images/icons/TC-33534-MainIcon.jpg")

    visit "/artists"
    click_on "Delete"

    expect(page).not_to have_content(artist1.name)
  end
  scenario "from the artist show page" do
    artist1 = Artist.create(name: "TrumpetPlayer", image_path: "http://www.talkshoe.com/custom/images/icons/TC-33534-MainIcon.jpg")

    visit "/artists/#{artist1.name}"
    click_on "Delete"

    expect(page).not_to have_content(artist1.name)
  end
end