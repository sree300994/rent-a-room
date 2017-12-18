class AddColumns < ActiveRecord::Migration
  def change
  	add_column :rooms, :slug, :string
  	add_column :cities, :slug, :string
  	add_column :amenities, :slug, :string
  end
end
