class SpecialPricesController < ApplicationController

	before_action :authenticate_user!
	load_and_authorize_resource

	def index
		@special_prices = SpecialPrice.all
	end

	def new
		@special_price = SpecialPrice.new
	end
	def create
		@special_price = SpecialPrice.new(special_price_params)
		@special_price.room_id = params[:room_id]
		if @special_price.save
			redirect_to rooms_path, notice: "Successfully created the Special Price"
		else
			render action: "new"
		end
	end

	private

	def special_price_params
		params.require(:special_price).permit(:start_date, :end_date, :price, :room_id)
	end
end
