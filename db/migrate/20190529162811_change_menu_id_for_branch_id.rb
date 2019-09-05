class ChangeMenuIdForBranchId < ActiveRecord::Migration[5.2]
  def change
    remove_column :orders, :menu_id
    add_reference :orders, :branch, foreign_key: true
  end
end
