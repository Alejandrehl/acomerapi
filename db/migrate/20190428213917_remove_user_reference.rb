class RemoveUserReference < ActiveRecord::Migration[5.2]
  def change
    # La lógica queda ligada a restaurant, y solo restaurant ligada al usuario que lo creo
    remove_reference :categories, :user
    add_reference :categories, :restaurant
    remove_reference :products, :user
    remove_reference :menus, :user
    remove_reference :branches, :user
  end
end
