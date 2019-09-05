class AddUrlImageToRestaurants < ActiveRecord::Migration[5.2]
  def change
    add_column :restaurants, :image, :string
    add_column :restaurants, :address, :string
    add_column :restaurants, :city, :string
  end
end
