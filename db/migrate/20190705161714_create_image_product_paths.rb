class CreateImageProductPaths < ActiveRecord::Migration[5.2]
  def change
    create_table :image_product_paths do |t|
      t.references :product, foreign_key: true
      t.string :url
      t.timestamps
    end
  end
end
