class AddRelationTableToOrder < ActiveRecord::Migration[5.2]
  def change
    add_reference :orders, :tables, foreign_key: true
  end
end
