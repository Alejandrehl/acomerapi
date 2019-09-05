class CreateAdminCookAccounts < ActiveRecord::Migration[5.2]
  def change
    create_table :admin_cook_accounts do |t|
      t.integer :id_admin
      t.integer :id_cook
      t.references :branch, foreign_key: true
    end
  end
end
