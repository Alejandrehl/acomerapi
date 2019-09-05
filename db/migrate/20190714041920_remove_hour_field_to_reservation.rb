class RemoveHourFieldToReservation < ActiveRecord::Migration[5.2]
  def change
    remove_column :reserves, :reservation_hour
  end
end
