class CreateBranches < ActiveRecord::Migration[5.2]
  def change
    create_table :branches do |t|
      t.string :name
      t.string :telephone
      t.string :street
      t.string :email_manager
      t.string :telephone_manager
      t.text :information
      t.string :hour_op
      t.string :hour_cl
      t.string :instragram_id
      t.string :instagram_api_token
      t.references :user, foreign_key: true
      t.references :restaurant, foreign_key: true

      t.timestamps
    end
  end
end
