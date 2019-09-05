class RemoveProductsToCategories < ActiveRecord::Migration[5.2]
  def change
    remove_column :categories, :product
  end
end
