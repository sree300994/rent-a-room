class SpecialPrice < ActiveRecord::Base

	belongs_to :room
	validates_presence_of :start_date, :end_date, :price

	validate :check_date

	def check_date
		if self.start_date < Date.today || self.end_date < self.start_date
			self.errors.add(:base, "The date you are trying to add should be equal or greater than Start Date")
		end
	end
end
