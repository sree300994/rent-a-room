class SpecialPricesController < ApplicationController

	before_action :authenticate_user!
	load_and_authorize_resource

	def index
		@special_prices = SpecialPrice.all
	end
end
