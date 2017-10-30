class DashboardController < ApplicationController
  
  def index
  	@bookings = current_user.bookings
  end

  def user
  	@users = User.all.where.not(role_id: Role.first.id)
  end
end
