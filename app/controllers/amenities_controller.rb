class AmenitiesController < ApplicationController

	before_action :set_amenity, only: [:show, :edit, :update, :destroy]
	before_action :authenticate_user!, except: [:index, :show]
	load_and_authorize_resource

	def index
		@amenities = Amenity.all
		@amenity = Amenity.new
	end

	# def new
	# 	@amenity = Amenity.new
	# end

	def create
		@amenity = Amenity.new(amenity_params)
		respond_to do |format|
	      if @amenity.save
	        format.html { redirect_to @amenity, notice: 'amenity was successfully created.' }
	        format.json { render :show, status: :created, location: @amenity }
	        format.js
	      else
	        format.html { render :new }
	        format.json { render json: @amenity.errors, status: :unprocessable_entity }
	        format.js
	      end
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
