require 'rails_helper'
require 'pp'

describe "Navigating rooms" do
  before { login_as user }

  let!(:user) { create :user }
  let!(:room) { create :room, user: user }

  it "allows navigation from the detail page to the listing page" do
    visit room_url(room)

    click_link "Back" # Name of the link as displayed in the browser

    expect(page).to have_content "Your Listings"
    expect(current_path).to eq rooms_path
  end

  it "allows navigation from the listing page to the detail page" do
	visit rooms_url

	click_link "View"

	expect(current_path).to eq(room_path(room))
  end
end
