class RoomsController < ApplicationController

	before_action :set_room, only: [:edit, :update, :show, :destroy]
	before_action :authenticate_user!, except: [:index, :show]
	load_and_authorize_resource
	# before_action :check_booking, only: :destroy
	# skip_before_filter :verify_authenticity_token  


	def index
		# @rooms = Room.all
		# @rooms = Room.paginate(:page => params[:page])
		@rooms = Room.where("is_authorized = ?", true).paginate(:page => params[:page], :per_page => 2)
	end

	def new
		@room = Room.new
	end

	def create
		@room = Room.new(room_params)
		@room.user_id = current_user.id
		respond_to do |format|
	      	if @room.save
		        format.html { redirect_to @room, notice: 'Successfully created the room' }
		        format.json { render :show, status: :created, location: @room }
		        format.js
	      	else
		        format.html { render :new }
		        format.json { render json: @room.errors, status: :unprocessable_entity }
		        format.js
	      	end
	  	end
	end

	def edit
	end

	def update
		puts "*************"
		respond_to do |format|
			if @room.update_attributes(room_params)
				Notification.room_authorization(@room).deliver_now!
				format.html { redirect_to @room, notice: "Successfully updated the room" }
				format.js
			else
				format.html{ render :edit }
				format.js
			end
		end
	end

	def show
		@booking = Booking.new
		@special_price = SpecialPrice.new
		@review = Review.new
	end

	def destroy
		if @room.destroy
			redirect_to rooms_path, notice: "Successfully deleted the room"
		else
			# redirect_to @room, notice: "#{@room.errors[:base]}"
		end
	end

	def mark_authorize
		if current_user.role?("admin")
			@rooms = Room.where("is_authorized = ?", false).all
		end
	end

	def my_rooms
		if current_user.role?("host") == true
			@rooms = current_user.rooms
		# else
			# redirect_to rooms_path, notice: "This page belongs to host"
		end
		# @rooms = Room.where("user_id = ?", current_user.id)
	end

	def check_bookings
		 binding.pry
		@bookings = Booking.where(["room_id = ? AND start_date > ?", params[:format], Date.today])
	end

	# def location
	# 	@address = HTTParty.get("http://maps.googleapis.com/maps/api/geocode/json?address=kadapa")
	# 	@location = JSON.parse(@address.body)	
		
	# end

	private

	def set_room
		@room = Room.find(params[:id])
	end

	def room_params
		params.require(:room).permit(:name, :is_authorized, :description, :price, :rules, :address, :images, :latitude, :longitude, :city_id, :user_id, :remove_images, amenity_ids:[])
	end

	# def check_booking
	# 	@room = Room.find(params[:id])
	# 	# binding.pry
	# 	if @room.bookings.any?
	# 		@room.bookings.each do |booking|
	# 			if booking.start_date >= Date.today
	# 				redirect_to rooms_check_bookings_path(@room.id), notice: "The room cannot be destroyed because of Future Bookings it have"
	# 			end
	# 		end
	# 	end
	# end
end







