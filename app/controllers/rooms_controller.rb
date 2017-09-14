class RoomsController < ApplicationController

before_action :authenticate_user!, except: [:index, :show]
load_and_authorize_resource

def index
	# @rooms = Room.all
	# @rooms = Room.paginate(:page => params[:page])
	@rooms = Room.where("is_authorized = ?", true).paginate(:page => params[:page], :per_page => 1)
	# @rooms = Room.all
end

def new
	@room = Room.new
end

def create
	@room = Room.new(room_params)
	@room.user_id = current_user.id
	if @room.save
		redirect_to new_room_path, notice: "Successfully created the room"
	else
		render action: "new"
	end
end

def edit
	@room = Room.find(params[:id])
end

def update
	@room = Room.find(params[:id])
	puts "*************"
	if @room.update_attributes(room_params)
		redirect_to room_path(@room.id), notice: "Successfully updated the room"
	else
		render action: "edit"
	end
end

def show
	@room = Room.find(params[:id])
end

def destroy
	@room = Room.find(params[:id])
	@room.destroy
	redirect_to rooms_path, notice: "Successfully deleted the room"
end

def mark_authorize
	if current_user.role?("admin")
		@rooms = Room.where("is_authorized = ?", false).all
	end
end

# def location
# 	@address = HTTParty.get("http://maps.googleapis.com/maps/api/geocode/json?address=kadapa")
# 	@location = JSON.parse(@address.body)	
	
# end

private

def room_params
	params.require(:room).permit(:name, :is_authorized, :description, :price, :rules, :address, :images, :latitude, :longitude, :city_id, :user_id, :remove_images, amenity_ids:[])
end

end




















