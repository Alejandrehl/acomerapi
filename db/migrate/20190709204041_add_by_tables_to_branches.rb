class AddByTablesToBranches < ActiveRecord::Migration[5.2]
  def change
    add_column :branches, :by_tables, :string
    add_column :branches, :step, :string
    remove_column :branches, :attentiontype
  end
end
