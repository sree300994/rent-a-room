class Review < ActiveRecord::Base

	belongs_to :room
	belongs_to :user
	validates_presence_of :review, :food_rating, :cleanliness_rating, :safety_rating, :facility_rating, :locality_rating
end
