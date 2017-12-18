class City < ActiveRecord::Base

	validates_presence_of :name
	validates_uniqueness_of :name
	has_many :rooms, dependent: :destroy
	extend FriendlyId
	friendly_id :name, use: [:slugged, :finders]
end
