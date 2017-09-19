class Booking < ActiveRecord::Base

	belongs_to :room
	belongs_to :user
	validates_presence_of :start_date, :end_date

	validate :check_date
	validate :booking_date, on: :create

	def check_date
		if self.start_date < Date.today || self.end_date < self.start_date
			self.errors.add(:date, "The date you are trying to book is not available")
		end
	end

	def booking_date
		date1 = self.start_date
		date2 = self.end_date
		present_date = (date1..date2).to_a
		total_booking = Booking.where("room_id = ?", self.room_id)
		total_booking.each do |booking|
			date3 = booking.start_date
			date4 = booking.end_date
			past_date = (date3..date4).to_a
			present_date.each do |date|
				if past_date.include?(date)
					self.errors.add(:base, "The date you are trying to book is already booked")
				end
			end
			break
		end
	end
end