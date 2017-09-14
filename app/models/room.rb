class Room < ActiveRecord::Base

	mount_uploader :images, ImagesUploader
	validates_presence_of :name, :description, :price, :rules, :address, :city_id
	has_many :amenity_rooms
	has_many :amenities, through: :amenity_rooms
	belongs_to :city
	belongs_to :user

	before_save :take_longitude_and_latitude_from_address
	after_create :change_role

	def take_longitude_and_latitude_from_address

		address = HTTParty.get("http://maps.googleapis.com/maps/api/geocode/json?address=#{self.address}")
		location = JSON.parse(address.body)
		puts location["results"][0]["formatted_address"]
		self.latitude = location["results"][0]["geometry"]["location"]["lat"]
		self.longitude = location["results"][0]["geometry"]["location"]["lng"]
	end

	def change_role
		if self.user.role?("guest")
			role = Role.find_by("name = ?", "host")
			self.user.role_id = role.id
			self.user.save
		end
	end
end