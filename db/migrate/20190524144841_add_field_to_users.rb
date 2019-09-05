class AddFieldToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :branch_number, :integer
  end
end
