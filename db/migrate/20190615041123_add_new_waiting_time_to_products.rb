class AddNewWaitingTimeToProducts < ActiveRecord::Migration[5.2]
  def change
    add_column :products, :waiting_time, :integer
  end
end
