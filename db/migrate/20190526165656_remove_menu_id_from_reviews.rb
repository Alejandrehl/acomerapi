class RemoveMenuIdFromReviews < ActiveRecord::Migration[5.2]
  def change
    remove_column :reviews, :date
    remove_reference :reviews, :menu
  end
end
