class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :room

  def self.get_total_price(room, booking_params)
    checkin, checkout = get_dates(booking_params)

    total_days = (checkout - checkin).to_i
    room.price * total_days
  end

  def self.get_dates(booking_params)
    checkin  =  Date.new(booking_params["starts_at(1i)"].to_i,
                         booking_params["starts_at(2i)"].to_i,
                         booking_params["starts_at(3i)"].to_i)

    checkout =  Date.new(booking_params["ends_at(1i)"].to_i,
                         booking_params["ends_at(2i)"].to_i,
                         booking_params["ends_at(3i)"].to_i)

    return checkin, checkout
  end

end
