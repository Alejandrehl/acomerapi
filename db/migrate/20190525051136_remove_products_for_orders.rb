class RemoveProductsForOrders < ActiveRecord::Migration[5.2]
  def change
    if column_exists? :orders, :products
      remove_column :orders, :products
    end
  end
end
