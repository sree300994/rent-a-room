class AmenitiesController < ApplicationController

	before_action :set_amenity, except: [:index, :new]
	before_action :authenticate_user!, except: [:index, :show]
	load_and_authorize_resource

	def index
		@amenities = Amenity.all
	end

	def new
		@amenity = Amenity.new
	end

	def create
		@amenity = Amenity.new(amenity_params)
		if @amenity.save
			redirect_to amenities_path, notice: "Successfully created the amenity"
		else
			render action: "new"
		end
	end

	def edit
		
	end

	def update
		
		if @amenity.update_attributes(amenity_params)
			redirect_to amenity_path(@amenity.id), notice: "Successfully updated the amenity"
		else
			render action: "edit"
		end
	end

	def show
		
	end

	def destroy
		
		@amenity.destroy
		redirect_to amenities_path, notice: "Successfully deleted the amenity"
	end

	private

	def set_amenity
		@amenity = Amenity.find(params[:id])
	end

	def amenity_params
		params.require(:amenity).permit(:name, :description)
	end

end
