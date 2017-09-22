class CitiesController < ApplicationController

	before_action :set_city, only: [:edit, :show, :destroy, :update]
	before_action :authenticate_user!, except: [:index, :show, :path_change]
	load_and_authorize_resource

	def index

		@cities = City.all
	end

	def new
		@city = City.new
	end

	def path_change

		if current_user.nil?
			puts "this"
			redirect_to cities_path	
		elsif current_user.role?("admin")
			puts "this1"
			redirect_to bookings_table_path
		elsif current_user.role?("host")
			puts "this2"
			redirect_to bookings_host_path
		else
			redirect_to cities_path
		end
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
