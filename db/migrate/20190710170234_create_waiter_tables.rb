class CreateWaiterTables < ActiveRecord::Migration[5.2]
  def change
    create_table :waiter_tables do |t|
      t.references :table, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
