class AddHourFieldToReservation < ActiveRecord::Migration[5.2]
  def change
    add_column :reserves, :reservation_hour, :date
  end
end
