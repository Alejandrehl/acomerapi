class CreateProductsOrdersJoinTable < ActiveRecord::Migration[5.2]
  def change
  # This is enough; you don't need to worry about order
  create_join_table :orders, :products
  end
end
