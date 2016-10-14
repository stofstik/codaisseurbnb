class BookingsController < ApplicationController
  before_action :authenticate_user!

  def create
    checkin, checkout = Booking.get_dates(booking_params)
    room = Room.find(booking_params[:room_id])

    if room.available?(checkin, checkout)
      total_price = Booking.get_total_price(room, booking_params)
      @booking = current_user.bookings.create(booking_params.merge(total: total_price))
      redirect_to @booking.room, notice: "Thank you for booking! Your total will be € #{total_price}"
    else
      redirect_to room, notice: "Sorry! This listing is not available during the dates you requested."
    end
  end

  private

  def booking_params
    params.require(:booking).permit(:starts_at, :ends_at, :room_id)
  end
end
