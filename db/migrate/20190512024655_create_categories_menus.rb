class CreateCategoriesMenus < ActiveRecord::Migration[5.2]
  def change
    create_table :categories_menus do |t|
      t.references :category, foreign_key: true
      t.references :menu, foreign_key: true

      t.timestamps
    end
  end
end
