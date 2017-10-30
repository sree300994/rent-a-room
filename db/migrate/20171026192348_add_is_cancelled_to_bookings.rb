class AddIsCancelledToBookings < ActiveRecord::Migration
  def change
    add_column :bookings, :is_cancelled, :boolean, default: false
  end
end
