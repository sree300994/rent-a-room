class AddColumnToBookings < ActiveRecord::Migration
  def change
    add_column :bookings, :price, :string
  end
end
