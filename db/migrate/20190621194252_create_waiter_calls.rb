class CreateWaiterCalls < ActiveRecord::Migration[5.2]
  def change
    create_table :waiter_calls do |t|
      t.references :table, foreign_key: true
    end
  end
end
