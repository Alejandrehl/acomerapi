class CreateRestaurants < ActiveRecord::Migration[5.2]
  def change
    create_table :restaurants do |t|
      t.string :name
      t.text :description
      t.string :business_name
      t.string :giro
      t.string :telephone
      t.string :email
      t.text :instagram
      t.text :facebook
      t.text :twitter
      t.text :pinterest
      t.text :tripadvisor
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
