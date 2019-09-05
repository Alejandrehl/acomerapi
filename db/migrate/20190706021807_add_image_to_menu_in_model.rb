class AddImageToMenuInModel < ActiveRecord::Migration[5.2]
  def change
    add_column :menus, :img_url, :string
  end
end
