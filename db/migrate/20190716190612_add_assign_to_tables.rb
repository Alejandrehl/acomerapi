class AddAssignToTables < ActiveRecord::Migration[5.2]
  def change
    add_column :tables, :assign, :boolean, default: false
  end
end
