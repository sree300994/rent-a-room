class CitiesController < ApplicationController

	before_action :set_city, except: [:index, :new]
	before_action :authenticate_user!, except: [:index, :show]
	load_and_authorize_resource

	def index
		@cities = City.all
		if current_user.nil?
			redirect_to rooms_path
		elsif current_user.role?("admin")
			redirect_to bookings_table_path
		elsif current_user.role?("host")
			redirect_to bookings_host_path
		elsif current_user.role?("guest")
			redirect_to rooms_path
		end
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
	end

	def update
		if @city.update_attributes(city_params)
			redirect_to city_path(@city.id), notice: "Successfully updated the City"
		else
			render action: "edit"
		end
	end

	def show
	end

	def destroy
		@city.destroy
		redirect_to cities_path, notice: "Successfully deleted the city"
	end

	private

	def set_city
		@city = City.find(params[:id])
	end

	def city_params
		params.require(:city).permit(:name)
	end

end
