class RemoveAttributeForOrders < ActiveRecord::Migration[5.2]
  def change
    remove_column :orders, :cart
    remove_column :orders, :id_cart
    remove_column :orders, :cart_type
    remove_reference :orders, :branch
  end
end
