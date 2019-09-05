class CreateRestaurantReviews < ActiveRecord::Migration[5.2]
  def change
    create_table :restaurant_reviews do |t|
      t.string :title
      t.text :review
      t.integer :stars
      t.references :restaurant, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
