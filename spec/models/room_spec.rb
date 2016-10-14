require 'rails_helper'

RSpec.describe Room, type: :model do

  describe "association with user" do
    let(:user) { create :user }

    it "belongs to a user" do
      room = user.rooms.new(home_type: "Shared")

      expect(room.user).to eq(user)
    end
  end

  describe "association with theme" do
    let(:user) { create :user }
    let(:room) { create :room, user: user }

    let(:theme1) { create :theme, name: "Bright", rooms: [room] }
    let(:theme2) { create :theme, name: "Clean lines", rooms: [room] }
    let(:theme3) { create :theme, name: "A Man's Touch", rooms: [room] }

    it "has themes" do
      expect(room.themes).to include(theme1)
      expect(room.themes).to include(theme2)
      expect(room.themes).to include(theme3)
    end
  end

  describe "validations" do
    it "is invalid without a home_type" do
      room = Room.new(home_type: "")
      room.valid?
      expect(room.errors).to have_key(:home_type)
    end

    it "is invalid with a listing name longer than 50 characters" do
      room = Room.new(listing_name: "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. ")
      room.valid?
      expect(room.errors).to have_key(:listing_name)
    end

    it "is valid without a price" do
      room = Room.new(price: "")
      room.valid?
      expect(room.errors).not_to have_key(:price)
    end
  end

  describe "#bargain?" do
    let(:bargain_room) { create :room, price: 20 }
    let(:non_bargain_room) { create :room, price: 200 }

    it "returns true if the price is smaller than 30 EUR" do
      expect(bargain_room.bargain?).to eq(true)
      expect(non_bargain_room.bargain?).to eq(false)
    end
  end

  describe "#order_by_price" do
    let!(:room1) { create :room, price: 100 }
    let!(:room2) { create :room, price: 200 }
    let!(:room3) { create :room, price: 300 }

    it "returns a sorted array of rooms by prices" do
      expect(Room.order_by_price).to match_array [room1, room2, room3]
    end
  end

  describe "association with booking" do
    let(:guest_user) { create :user, email: "guest@user.com" }
    let(:host_user) { create :user, email: "host@user.com" }

    let!(:room) { create :room, user: host_user }
    let!(:booking) { create :booking, room: room, user: guest_user }

    it "has guests" do
      expect(room.guests).to include(guest_user)
    end
  end

end
