class CreateReserve < ActiveRecord::Migration[5.2]
  def change
    create_table :reserves do |t|
      t.boolean :mode
      t.datetime :reservation_day
      t.datetime :reservation_hour
      t.integer :number_people
      
      t.references :user, foreign_key: true
      t.references :order, foreign_key: true

      t.timestamps
    end

    remove_column :orders, :reservation_time
  end
end
