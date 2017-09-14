class CreateRooms < ActiveRecord::Migration
  def change
    create_table :rooms do |t|
      t.string :name
      t.text :description
      t.string :price
      t.text :rules
      t.text :address
      t.string :images
      t.float :latitude
      t.float :longitude
      t.integer :city_id
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
