class ChangeTransactionError < ActiveRecord::Migration[5.2]
  def change
    remove_column :orders, :transaction, :string
    add_column :orders, :payment_method, :text
  end
end
