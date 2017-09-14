# # class AdminsController < ApplicationController
# class PortalsController < ApplicationController

# 	before_action :authenticate_user!
# 	load_and_authorize_resource
	
# 	def rooms
# 		# if current_user.role?("admin")
# 			@rooms = Room.where("is_authorized = ?", false).all
# 			 authorize! :rooms, @rooms
# 		# else
# 			# @rooms = Room.all
# 		# end
# 	end

# end