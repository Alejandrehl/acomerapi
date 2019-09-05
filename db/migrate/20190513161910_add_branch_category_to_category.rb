class AddBranchCategoryToCategory < ActiveRecord::Migration[5.2]
  def change
    add_column :branches, :branch_category, :text
  end
end
