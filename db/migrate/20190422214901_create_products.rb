class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.string :name
      t.text :description
      t.integer :price
      t.integer :cost
      t.string :ingredient
      t.integer :calories
      t.integer :proteins
      t.integer :carbohydrates
      t.integer :saturated_fats
      t.integer :unsaturated_fats
      t.boolean :vegan
      t.boolean :vegetarian
      t.boolean :specialty
      t.boolean :activated
      t.integer :value_offer
      t.references :restaurant, foreign_key: true

      t.timestamps
    end
  end
end
