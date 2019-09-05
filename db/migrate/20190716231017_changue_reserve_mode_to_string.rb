class ChangueReserveModeToString < ActiveRecord::Migration[5.2]
  def change
    remove_column :reserves, :mode
    add_column :reserves, :mode, :string
  end
end
