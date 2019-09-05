class StatusToRestaurants < ActiveRecord::Migration[5.2]
  def change
    add_column :restaurants, :status, :string, default: 'pending'
  end
end
