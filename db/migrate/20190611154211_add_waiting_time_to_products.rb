class AddWaitingTimeToProducts < ActiveRecord::Migration[5.2]
  def change
    add_column :products, :waitiing_time, :datetime
  end
end
