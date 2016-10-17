require 'rails_helper'

RSpec.describe Booking, type: :model do

  describe "is made" do

    # Set up some users
    let(:host_user) { create :user, email: "host@user.com" }
    let(:guest_user) { create :user, email: "guest@user.com" }

    # Set up a room and a booking on it
    let!(:room) { create :room, price: 20, user: host_user }
    let(:room_without_booking) { create :room, price: 20, user: host_user }
    let!(:existent_booking) { create :booking, room: room, starts_at: 2.days.from_now, ends_at: 6.days.from_now, user: guest_user }

    it "we can book before it" do
      expect(Booking.during(1.days.from_now, 2.days.from_now)).not_to include(existent_booking)
    end
    it "we can book after it" do
      expect(Booking.during(8.days.from_now, 9.days.from_now)).not_to include(existent_booking)
    end

    it "we cannot book during it" do
      expect(Booking.during(1.days.from_now, 3.days.from_now)).to include(existent_booking)
    end

    it "we cannot book during it" do
      expect(Booking.during(3.days.from_now, 11.days.from_now)).to include(existent_booking)
    end

    it "we cannot book during it" do
      expect(Booking.during(3.days.from_now, 5.days.from_now)).to include(existent_booking)
    end

  end

end
