class AddMissingIndexes < ActiveRecord::Migration[5.2]
  def change
    add_index :orders_products, :order_id
    add_index :orders_products, :product_id
    add_index :orders_products, [:order_id, :product_id]
  end
end
