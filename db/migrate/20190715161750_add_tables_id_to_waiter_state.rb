class AddTablesIdToWaiterState < ActiveRecord::Migration[5.2]
  def change
    add_reference :waiter_states, :table, foreign_key: true
  end
end
