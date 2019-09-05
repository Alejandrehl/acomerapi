class ChangeReviewsRelationsError < ActiveRecord::Migration[5.2]
  def change
    remove_column :reviews, :menus_id
    add_reference :reviews, :menu, foreign_key: true
  end
end
