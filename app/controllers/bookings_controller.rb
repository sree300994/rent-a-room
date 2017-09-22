class BookingsController < ApplicationController

	before_action :set_booking, only: [:update]
	before_action :authenticate_user!
	load_and_authorize_resource

	def index
		@bookings = current_user.bookings
	end

	def create
		@booking = Booking.new(booking_params)
		@booking.user_id = current_user.id
		if @booking.save
			Notification.booking_created(@booking).deliver_now!
			Notification.booking_status(@booking).deliver_now!
			redirect_to bookings_path
		else
			redirect_to rooms_path, notice: "#{@booking.errors[:base]}"
		end
	end

	def update
		# binding.pry
		if @booking.update_attributes(booking_params)
			Notification.booking_confirmation(@booking).deliver_now!
			redirect_to bookings_path, notice: "Successfully updated the booking"
		else
			redirect_to bookings_unconfirmed_path, notice: "You are unable to update the booking"
		end
	end

	def table
		@bookings = Booking.all
	end

	def host
		@bookings = Booking.all
	end

	def unconfirmed
		if current_user.role?("host")
			@bookings = Booking.where("is_confirmed = ?", false).all
		end
	end

	private

	def set_booking
		@booking = Booking.find(params[:id])
	end

	def booking_params
		params.require(:booking).permit(:start_date, :end_date, :user_id, :room_id, :is_confirmed, :price)
	end
end
