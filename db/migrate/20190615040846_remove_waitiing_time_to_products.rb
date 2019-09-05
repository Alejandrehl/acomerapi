class RemoveWaitiingTimeToProducts < ActiveRecord::Migration[5.2]
  def change
    remove_column :products, :waitiing_time
  end
end
