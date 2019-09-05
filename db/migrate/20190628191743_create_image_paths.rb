class CreateImagePaths < ActiveRecord::Migration[5.2]
  def change
    create_table :image_paths do |t|
      t.references :branch, foreign_key: true
      t.string :url
      t.timestamps
    end
  end
end
