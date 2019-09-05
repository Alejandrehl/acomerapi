class ChangeColumnNameForBranches < ActiveRecord::Migration[5.2]
  def change
    if column_exists? :branches, :instragram_id
      rename_column :branches, :instragram_id, :instagram_id
    end
  end
end
