class RemoveRestaurantIdFromCategories < ActiveRecord::Migration[5.2]
  def change
    remove_reference :categories, :restaurant
  end
end
