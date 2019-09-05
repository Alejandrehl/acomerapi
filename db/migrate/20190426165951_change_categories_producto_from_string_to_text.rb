class ChangeCategoriesProductoFromStringToText < ActiveRecord::Migration[5.2]
  def change
    remove_column :categories, :product, :string
    add_column :categories, :product, :text, array: true, default: []
  end
end
