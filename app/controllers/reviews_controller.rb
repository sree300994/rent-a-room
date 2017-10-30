class ReviewsController < ApplicationController
	before_action :authenticate_user!, except: [:index]
	load_and_authorize_resource

	def index
		@reviews = Review.all
	end

	def create
		@review = Review.new(review_params)
		@review.user_id = current_user.id
		if @review.save
			redirect_to rooms_path, notice: "Successfully created the Review"
		end
	end

	def destroy
		@review = Review.find(params[:id])
		@review.destroy
		redirect_to :back, notice: "Successfully deleted the Review"
	end

	private

	def review_params
		params[:review].permit(:review, :food_rating, :cleanliness_rating, :safety_rating, :facility_rating, :locality_rating, :room_id, :user_id)
	end
end
