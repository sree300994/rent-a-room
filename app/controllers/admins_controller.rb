class AdminsController < ApplicationController

	before_action :authenticate_user!
	# load_and_authorize_resource
	authorize_resource class: false
	def rooms
		if current_user.role?("admin")
			@rooms = Room.where("is_authorized = ?", false).all
		end
	end
end
