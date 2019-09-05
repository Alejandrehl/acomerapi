class RemoveReferenceRestaurantOnProducts < ActiveRecord::Migration[5.2]
  def change
    remove_column :products, :restaurant_id
    add_reference :products, :user, foreign_key: true
  end
end
