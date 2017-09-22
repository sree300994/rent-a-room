class Booking < ActiveRecord::Base

	belongs_to :room
	belongs_to :user
	validates_presence_of :start_date, :end_date

	validate :check_date
	validate :booking_date, on: :create
	validate :total, on: :create

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

	def total
		# binding.pry
		if room.special_prices.any?
			intial_date = self.start_date
			final_date = self.end_date
			booked_dates = (intial_date..final_date).to_a
			offer_dates = SpecialPrice.where("room_id = ?", self.room_id)
			# binding.pry
			offer_dates.each do |offer_date|
				# binding.pry
				date1 = offer_date.start_date
				date2 = offer_date.end_date
				offer_days = (date1..date2).to_a
				booked_dates.each do |date|
					# binding.pry
					if offer_days.include?(date)
						self.price = self.price.to_i + offer_date.price.to_i
					else
						self.price = self.price.to_i + self.room.price.to_i
					end
				end
			end
		else	
			date1 = self.start_date
			date2 = self.end_date
			present_date = (date1..date2).to_a
			self.price = (present_date.length) * (self.room.price.to_i)
		end
	end
end