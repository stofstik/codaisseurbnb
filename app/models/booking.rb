class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :room
  before_create :set_check_in_times

  # Pluck returns the fields received from the previous query
  def self.booked_during arrival, departure
    Booking.during(arrival, departure).pluck(:room_id)
  end

  def self.during arrival, departure
    arrival = arrival.change(hour: 14, min: 00, sec: 00)
    departure = departure.change(hour: 11, min: 00, sec: 00)
    starts_before_ends_after(arrival, departure).or( ends_during(arrival, departure) ).or(start_during(arrival,departure))
  end


  def self.starts_before_ends_after arrival, departure
    where('starts_at <= ?', arrival).where('ends_at >= ?', departure)
  end

  def self.start_during arrival, departure
    where('starts_at <= ?', arrival).where('ends_at >= ?', arrival)
  end

  def self.ends_during arrival, departure
    where('starts_at <= ?', departure).where('ends_at >= ?', departure)
  end

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

  private
    def set_check_in_times
      self.starts_at = starts_at.change(hour: 14, min: 00, sec: 00)
      self.ends_at = ends_at.change(hour: 11, min: 00, sec: 00)
    end

end
