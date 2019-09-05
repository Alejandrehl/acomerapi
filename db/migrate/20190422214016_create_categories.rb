class CreateCategories < ActiveRecord::Migration[5.2]
  def change
    create_table :categories do |t|
      t.string :name
      t.text :description
      t.string :product
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
