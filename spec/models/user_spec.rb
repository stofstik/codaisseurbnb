require 'rails_helper'

RSpec.describe User, type: :model do
  describe "association with room" do
    let(:user) { create :user }
    let!(:room) { create :room, user: user }

    it "has many rooms" do
      room1 = user.rooms.new(listing_name: "Wonderful")
      room2 = user.rooms.new(listing_name: "Extraordinary")

      expect(user.rooms).to include(room1)
      expect(user.rooms).to include(room2)
    end

    it "deletes associated rooms" do
      expect { user.destroy }.to change(Room, :count).by(-1)
    end
  end

  describe "association with booking" do
	let(:guest_user) { create :user, email: "guest@user.com" }
	let(:host_user) { create :user, email: "host@user.com" }

	let!(:room) { create :room, user: host_user }
	let!(:booking) { create :booking, room: room, user: guest_user }

	it "has bookings" do
	  expect(guest_user.booked_rooms).to include(room)
	end
  end

  describe "Signs in" do

    let(:old_user) { create :user, email: "test@email.com", last_sign_in_at: Time.now - 4.months }
    let(:active_user) { create :user, email: "test@email.com", last_sign_in_at: Time.now - 2.months }

    # Check for a certain method using 'respond_to?'
    it "has a method active_users" do
      expect(User.respond_to?('active_users')).to be true
    end

    it "expects a user who has not signed in for 4 months to not be active" do
      expect(User.active_users).not_to include(old_user)
    end

    it "expects a user who has not signed in for 2 months to be active" do
      expect(User.active_users).to include(active_user)
    end
  end

end
