class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.string :products
      t.integer :total
      t.string :transaction
      t.string :status
      t.string :request_type
      t.text :specification
      t.string :reservation
      t.boolean :cart
      t.integer :id_cart
      t.string :cart_type
      t.references :user, foreign_key: true
      t.references :menu, foreign_key: true
      t.references :branch, foreign_key: true

      t.timestamps
    end
  end
end
