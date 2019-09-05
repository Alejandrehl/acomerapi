class CreateWaiterStates < ActiveRecord::Migration[5.2]
  def change
    create_table :waiter_states do |t|
      t.string :reason
    end
  end
end
