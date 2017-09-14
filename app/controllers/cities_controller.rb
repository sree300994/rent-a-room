class CitiesController < ApplicationController
	before_action :authenticate_user!, except: [:index, :show]
	load_and_authorize_resource

	def index
		@cities = City.all
	end

	def new
		@city = City.new
	end

	def create
		@city = City.new(city_params)
		if @city.save
			redirect_to cities_path, notice: "Successfully created the City"
		else
			render action: "new"
		end
	end

	def edit
		@city = City.find(params[:id])
	end

	def update
		@city = City.find(params[:id])
		if @city.update_attributes(city_params)
			redirect_to city_path(@city.id), notice: "Successfully updated the City"
		else
			render action: "edit"
		end
	end

	def show
		@city = City.find(params[:id])
	end

	def destroy
		@city = City.find(params[:id])
		@city.destroy
		redirect_to cities_path, notice: "Successfully deleted the city"
	end

	private

	def city_params
		params.require(:city).permit(:name)
	end

end
