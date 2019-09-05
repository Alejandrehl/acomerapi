class AddCategoryReferencesToMenu < ActiveRecord::Migration[5.2]
  def change
    remove_column :menus, :category
    add_reference :menus, :categories, foreign_key: true
  end
end
