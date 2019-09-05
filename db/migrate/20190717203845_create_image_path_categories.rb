class CreateImagePathCategories < ActiveRecord::Migration[5.2]
  def change
    create_table :image_path_categories do |t|
      t.references :categories, foreign_key: true
      t.string :url
      t.timestamps
    end
  end
end
