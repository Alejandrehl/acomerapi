class AddLatLengToBranch < ActiveRecord::Migration[5.2]
  def change
    add_column :branches, :lat, :float
    add_column :branches, :leng, :float
  end
end