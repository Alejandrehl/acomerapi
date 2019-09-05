class UpdateColumnsForOrders < ActiveRecord::Migration[5.2]
  def change
    remove_column :orders, :request_type
    add_column :orders, :reservation_time, :datetime, null: true
  end

  def self.up
    change_column :orders, :reservation, :string
  end
 
  def self.down
    change_column :orders, :reservation, :boolean
  end

end
