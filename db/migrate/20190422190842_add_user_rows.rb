class AddUserRows < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :name, :string
    add_column :users, :last_name, :string
    add_column :users, :phone, :string
    add_column :users, :rut, :string
    add_column :users, :birthdate, :date
    add_column :users, :gender, :string
    add_column :users, :provider, :string
    add_column :users, :uid, :string
    add_column :users, :image, :text
    add_column :users, :biography, :string
    add_column :users, :linkedin, :string
    add_column :users, :twitter, :string
    add_column :users, :web, :string
    add_column :users, :instagram, :string
    add_column :users, :exp, :string
    add_column :users, :admin, :boolean
  end
end
