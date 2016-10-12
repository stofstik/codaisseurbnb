require 'rails_helper'

describe "Viewing an individual room" do
  let(:user) { create :user }
  let(:room) { create :room, user: user }

  it "shows the room's details" do
    visit room_url(room)

    expect(page).to have_content room.home_type
    expect(page).to have_content room.accommodate
    expect(page).to have_content room.bedroom_count
    expect(page).to have_content room.bathroom_count
    expect(page).to have_content room.listing_name
    expect(page).to have_content room.description
    expect(page).to have_content room.address
  end
end
