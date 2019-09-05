class ChangeReservationHourTipe < ActiveRecord::Migration[5.2]
  def change
    remove_column :reserves, :reservation_hour, :date
    add_column :reserves, :reservation_hour, :datetime
  end
end
