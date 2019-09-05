class CreateAdminWaiterAccount < ActiveRecord::Migration[5.2]
  def change
    create_table :admin_waiter_accounts do |t|
      t.integer :id_admin
      t.integer :id_waiter
      t.references :branch, foreign_key: true
    end
  end
end
