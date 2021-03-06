class Room < ApplicationRecord
  belongs_to :user
  has_and_belongs_to_many :themes
  has_many :photos
  has_many :bookings, dependent: :destroy
  has_many :guests, through: :bookings, source: :user

  validates :home_type, presence: true
  validates :room_type, presence: true
  validates :accommodate, presence: true
  validates :bedroom_count, presence: true
  validates :bathroom_count, presence: true
  validates :listing_name, presence: true, length: {maximum: 50}
  validates :description, presence: true, length: {maximum: 500}
  validates :address, presence: true
  # TODO
  # validates :available?

  scope :single_bedroom, -> { where(bedroom_count: 1) }
  scope :for_couples, -> { single_bedroom.where(accommodate: 2) }

  def bargain?
	price < 30
  end

  def self.order_by_price
    order(:price)
  end

  # Pluck returns the fields received from the previous query
  def self.booked_during arrival, departure
    Booking.during(arrival, departure).pluck(:room_id)
  end

  def self.available_during arrival, departure
    where.not(id: booked_during(arrival, departure))
  end

  # TODO
  def available?(checkin, checkout)
    bookings.each do |booking|
      if (booking.starts_at <= checkout) && (booking.ends_at >= checkin)
        errors.add(:expiration_date, "can't be in the past")
        return false
      end
    end

    true
  end


end
