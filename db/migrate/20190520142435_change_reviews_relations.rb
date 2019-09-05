class ChangeReviewsRelations < ActiveRecord::Migration[5.2]
  def change
    remove_column :reviews, :restaurant_id
    add_reference :reviews, :menus, foreign_key: true
  end
end
