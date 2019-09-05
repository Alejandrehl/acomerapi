class CreateAdminBranchLeaders < ActiveRecord::Migration[5.2]
  def change
    create_table :admin_branch_leaders do |t|
      t.integer :id_admin
      t.integer :id_leader
      t.references :branch, foreign_key: true
    end
  end
end
