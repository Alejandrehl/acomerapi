class AddChangeToImagePathCategory < ActiveRecord::Migration[5.2]
  def change
    remove_column :image_path_categories, :categories_id
    add_reference :image_path_categories, :category, foreign_key: true
  end
end
