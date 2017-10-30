class Notification < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notification.room_authorization.subject
  #
  def room_authorization(rooms)
    @room = rooms

    mail to: "#{@room.user.email}", subject: "Room authorized"
  end

  def booking_created(booking)
  	@booking = booking

  	mail to: "#{@booking.user.email}", subject: "Booking created need to be confirmed by host"
  end

  def booking_confirmation(booking)
  	@booking = booking
  	mail to: "#{@booking.user.email}", subject: "Booking has been confirmed successfully"
  end

  def booking_status(booking)
  	@booking = booking
  	mail to: "#{@booking.room.user.email}", subject: "Booking has been created by the #{@booking.user.username}"
  end

  def booking_cancellation(booking)
    @booking = booking
    mail to: "#{@booking.room.user.email}", subject: "Booking has been cancelled by the #{@booking.user.username}"
  end
end
